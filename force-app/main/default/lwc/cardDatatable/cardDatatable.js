import { LightningElement, wire, track } from 'lwc';
import getCartData from '@salesforce/apex/CartHandler.getCartItems';
 
const columns = [
    { label: 'Cart Item Name', fieldName: 'Name', type: 'text' },
    // { label: 'Product', fieldName: 'Product', type: 'text' },
    { label: 'Quantity', fieldName: 'Quantity', type: 'number' },
    { label: 'Total Price', fieldName: 'TotalPrice', type: 'currency' }
];
 
export default class CartDatatable extends LightningElement {
    // cartData
    // columns = columns;
    @track cartData;
    @track columns = columns;
    @track totalOrder = 0;
    @track totalProducts =0;

    @wire(getCartData)
    wiredCartItems({ error, data }) {
        if (data) {
            this.cartData = data.map(cart => ({  
                Name : cart.Name,
                Quantity: cart.Quantity__c,
                // Product :cart.Product__r.Name,
                TotalPrice: cart.Line_Total__c
            }));
            this.calculateTotalOrder();
            this.calculateTotalProducts(); 
        } else if (error) {
            this.cartData = undefined;
            console.error('Error retrieving cart data', error);
        }
    }

        calculateTotalOrder(){
            this.totalOrder = this.cartData.reduce((total, item) => total + item.TotalPrice, 0);
        }
        calculateTotalProducts(){
            this.totalProducts = this.cartData.reduce((total) => total + 1, 0);
        }
    }