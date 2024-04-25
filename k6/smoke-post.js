import http from "k6/http"
import { randomIntBetween } from 'https://jslib.k6.io/k6-utils/1.2.0/index.js';

const url = 'http://demoapp-dev-1621236630.us-east-1.elb.amazonaws.com/owners/new';

export default function(){
    let formData = {
        firstName: 'Juan',
        lastName: "Perez " + randomIntBetween(1, 1000),
        address: 'San Salvador',
        city: 'San Salvador',
        telephone: '555555555'
    };
    let headers = { 'Content-Type': 'application/x-www-form-urlencoded' };
    let response = http.post(url, formData, { headers: headers });
    console.log(response.status)
}