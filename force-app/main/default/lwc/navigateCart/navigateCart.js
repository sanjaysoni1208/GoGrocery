import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigateCart extends NavigationMixin(LightningElement) {

    handleClick(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Cart__c',
                actionName: 'home'
            },
            
        });
    }
    handleClick1(event){
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Address__c',
                actionName: 'home'
            },
        });
    }
}
