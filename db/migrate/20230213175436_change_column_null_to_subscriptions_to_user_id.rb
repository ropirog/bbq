class ChangeColumnNullToSubscriptionsToUserId < ActiveRecord::Migration[7.0]
  def change
    change_column_null :subscriptions, :user_id, from: false, to: true
  end
end
