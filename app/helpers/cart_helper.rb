module CartHelper
    def find_cart_item(service)
        @item = @cart.cart_items.find_by(service_id: service.id)
    end

    def require_cart_items
        unless current_user.admin? || @cart.cart_items.any?
            redirect_to categories_path
        end
    end

    def require_booking
        unless session[:booking_id] || params[:booking_id]
            redirect_to categories_path
        end
    end
end
