import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
    connect() {
        createConsumer().subscriptions.create({ channel: "ProductChannel", room: this.element.dataset.product_id }, {
            received(data){
                if (data.action === "updated"){
                    location.reload()
                }
            }
        })
    }
}
