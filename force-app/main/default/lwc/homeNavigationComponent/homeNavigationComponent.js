import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';


export default class HomeNavigationComponent extends NavigationMixin(LightningElement) {
    myURL ='https://gogrocerycom-dev-ed.develop.my.site.com/s/';

    //! Go to Deployed Experience page
    handleClick(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: this.myURL
            }
        });
    }

    //? Show Product Details
    handleClick1(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Product__c',
                actionName: 'list'
            },
            state:{
                filterName: 'All'
            }
        });
    }

    //! Create a new Product
    handleClick2(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Product__c',
                actionName: 'new'
            },
        });
    }

    //? Show Order Details
    handleClick3(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Order__c',
                actionName: 'list'
            },
            state:{
                filterName: 'All'
            }
        });
    }

    //! Create a new Order
    handleClick4(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Order__c',
                actionName: 'new'
            },
            
        });
    }
    //? Show Voucher Records
    handleClick5(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Voucher__c',
                actionName: 'list'
            },
            state:{
                filterName: 'All'
            }
        });
    }

    //! Create a new Voucher
    handleClick6(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Voucher__c',
                actionName: 'new'
            },
            
        });
    }
    //? Show Cart Details
    handleClick7(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Cart__c',
                actionName: 'list'
            },
            state:{
                filterName: 'All'
            }
        });
    }

    //! Create a new Cart
    handleClick8(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Cart__c',
                actionName: 'new'
            },
        });
    }

    // ! Go to app home page
    handleClick9() {
        this[NavigationMixin.Navigate]({
            type: 'standard__app',
            attributes: {
                appTarget: 'c__GoGrocery',
            }
        });
    }
}