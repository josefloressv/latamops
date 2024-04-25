import { sleep } from "k6"
import http from "k6/http"
export const options = {
    stages: [
        {
            target: 100,
            duration: "1m"
        },
        {
            target: 200,
            duration: "1m" 
        },
        {
            target: 400,
            duration: "2m" 
        },
        {
            target: 0,
            duration: "1m" 
        }
    ],
}
export default function(){
    let response = http.get("http://demoapp-dev-1621236630.us-east-1.elb.amazonaws.com/owners?lastName=")
    sleep(1)
}