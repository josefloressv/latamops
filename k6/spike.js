import { sleep } from "k6"
import http from "k6/http"
export const options = {
    stages: [
        {
            target: 100,
            duration: "30s"
        },
        {
            target: 400,
            duration: "30s" 
        }
    ],
}
export default function(){
    let response = http.get("http://demoapp-dev-1621236630.us-east-1.elb.amazonaws.com")
    sleep(1)
}