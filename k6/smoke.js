import http from "k6/http"

export default function(){
    let response = http.get("http://demoapp-dev-1621236630.us-east-1.elb.amazonaws.com/owners?lastName=")
}