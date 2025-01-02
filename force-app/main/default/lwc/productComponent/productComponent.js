import { LightningElement, wire, track } from 'lwc';
 
// ! wire identifier are getProducts, addToCart and removeFromCart.
import getProducts from '@salesforce/apex/CartController.getProducts';
import addToCart from '@salesforce/apex/CartController.addToCart';
import removeFromCart from '@salesforce/apex/CartController.removeFromCart';
 
export default class ProductCatalogue extends LightningElement {
    @track products = [];
 
    @wire(getProducts)
    wiredProducts({ error, data }) {
        if (data) {
            this.products = data.map(({ Product_Image__c, ...rest }) => {
                const imgSrc = new DOMParser()
                    .parseFromString(Product_Image__c || '', 'text/html')
                    .querySelector('img')?.src || null;
                return { ...rest, Product_Image__c: imgSrc };
            });
            this.error = undefined;
 
        }
        else if (error) {
            this.error = error;
            this.products = [];
        }
    }
 
 
    handleAddToCart(event) {
        const productId = event.target.dataset.id;
        addToCart({ productId, quantity: 1 })
            .then(() => {
                console.log('Product added to cart');
            })
            .catch(error => {
                console.log('Product not added to cart');
                console.error(error);
            });
    }
 
    handleRemoveFromCart(event) {
        const productId = event.target.dataset.id;
        removeFromCart({ productId, quantity: 1 })
            .then(() => {
                console.log('Product removed from cart');
            })
            .catch(error => {
                console.log('Product is not removed from cart');
                console.error(error);
            });
    }
}
