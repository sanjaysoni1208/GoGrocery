import { LightningElement, track } from 'lwc';
 
export default class ThreeCardComponent extends LightningElement {
    @track cards = [
        { id: 1, imageUrl: 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg', name: 'Image 1', price: '$10' },
        { id: 2, imageUrl: 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg', name: 'Image 2', price: '$20' },
        { id: 3, imageUrl: 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg', name: 'Image 3', price: '$30' },
        { id: 4, imageUrl: 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg', name: 'Image 4', price: '$40' },
        { id: 5, imageUrl: 'https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg', name: 'Image 5', price: '$50' }
    ];
}