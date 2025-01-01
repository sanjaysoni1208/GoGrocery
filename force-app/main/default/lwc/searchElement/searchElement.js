import { LightningElement, wire, track } from 'lwc';
import LightningModal from 'lightning/modal';
import getProducts from '@salesforce/apex/findProductClass.getProduct';

const columns = [
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'Category', fieldName: 'Category__c' },
    { label: 'Stock Quantity', fieldName: 'Stock_Quantity__c' },
    { label: 'Availability', fieldName: 'IsActive__c' },
    { label: 'Unit Price', fieldName: 'Unit_Price__c' },
    { label: 'Unit Of Measurement', fieldName: 'Unit_Of_Measurement__c' }
];

export default class SearchElement extends LightningElement {
    name;
    @track products = [];

    @wire(getProducts, { searchText: '$name' })
    prodData({ data, error }) {
        if (data) {
            this.products = data.map(prod => ({
                ...prod,
                link: `https://cognizant-3ec-dev-ed.develop.my.site.com/s/product/${prod.Id}`
            }));
        } else if (error) {
            this.products = [];
            console.error('Error:', error);
        }
    }

    handleChange(event) {
        this.name = event.target.value;
        if (!this.name) {
            this.products = [];
        }
    }

    handleclick(event) {
        
        
    }

    columnlist = columns;
}