class ChangeSubscriptionsColumns < ActiveRecord::Migration[7.0]
  def change
    change_column_null :subscriptions, :user_email, from: true, to: false
    change_column_null :subscriptions, :user_name, from: true, to: false
    change_column :subscriptions, :user_email, :string, default: ""
    change_column :subscriptions, :user_name, :string, default: ""
  end
end
