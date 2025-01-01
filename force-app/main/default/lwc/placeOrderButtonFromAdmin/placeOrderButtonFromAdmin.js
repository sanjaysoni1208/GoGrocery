import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createOrder from '@salesforce/apex/OrderCreationHandler.createOrder';

export default class NavigateToOrderPage extends NavigationMixin(LightningElement) {
    handlePlaceOrder() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Order__c',
                actionName: 'new'
            }
        });
    }
}