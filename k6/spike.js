import { sleep } from "k6"
import http from "k6/http"

const url = "http://demoapp-dev-327614256.us-east-1.elb.amazonaws.com/owners?lastName=";

export const options = {
    stages: [
        {
            target: 800,
            duration: "30s"
        },
        {
            target: 400,
            duration: "20s" 
        },
        {
            target: 0,
            duration: "10s" 
        }
    ],
}
export default function(){
    let response = http.get(url)
    sleep(1)
}