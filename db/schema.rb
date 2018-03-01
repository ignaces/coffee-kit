# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140925175254) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.decimal  "shipping_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",      default: true
  end

  create_table "coffee_bean_selections", force: true do |t|
    t.integer  "coffee_bean_id"
    t.integer  "subscription_month_id"
    t.integer  "grams"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coffee_beans", force: true do |t|
    t.string   "name"
    t.string   "sku"
    t.string   "origin_country"
    t.boolean  "is_active",          default: true
    t.integer  "grams_stock",        default: 0
    t.integer  "grams_package",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "toaster"
    t.string   "available_packages",                array: true
  end

  add_index "coffee_beans", ["grams_package"], name: "index_coffee_beans_on_grams_package", using: :btree
  add_index "coffee_beans", ["grams_stock"], name: "index_coffee_beans_on_grams_stock", using: :btree
  add_index "coffee_beans", ["is_active"], name: "index_coffee_beans_on_is_active", using: :btree
  add_index "coffee_beans", ["origin_country"], name: "index_coffee_beans_on_origin_country", using: :btree

  create_table "communes", force: true do |t|
    t.string   "slug"
    t.string   "name"
    t.integer  "city_id"
    t.decimal  "shipping_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_active",      default: true
  end

  add_index "communes", ["city_id"], name: "index_communes_on_city_id", using: :btree

  create_table "coupons", force: true do |t|
    t.string   "code"
    t.integer  "activations",         default: 0
    t.integer  "allowed_activations", default: 1
    t.integer  "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "payment_id"
    t.integer  "status"
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "uuid"
    t.integer  "shipping_address_id"
    t.datetime "completed_at"
    t.integer  "coupon_id"
    t.datetime "confirmation_email_sent_at"
    t.decimal  "shipping_price",             default: 0.0
    t.decimal  "subtotal_price"
  end

  add_index "orders", ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
  add_index "orders", ["payment_id"], name: "index_orders_on_payment_id", using: :btree
  add_index "orders", ["remember_token"], name: "index_orders_on_remember_token", using: :btree
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree
  add_index "orders", ["status"], name: "index_orders_on_status", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree
  add_index "orders", ["uuid"], name: "index_orders_on_uuid", unique: true, using: :btree

  create_table "orders_products", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.integer  "quantity"
    t.decimal  "product_price"
    t.decimal  "total_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "coffee_types",  default: [], array: true
  end

  add_index "orders_products", ["order_id", "product_id"], name: "index_orders_products_on_order_id_and_product_id", unique: true, using: :btree
  add_index "orders_products", ["order_id"], name: "index_orders_products_on_order_id", using: :btree
  add_index "orders_products", ["product_id"], name: "index_orders_products_on_product_id", using: :btree

  create_table "payments", force: true do |t|
    t.string   "type"
    t.string   "currency"
    t.integer  "status"
    t.string   "paypal_token"
    t.string   "paypal_payer_id"
    t.string   "paypal_transaction_id"
    t.string   "khipu_transaction_id"
    t.string   "khipu_url"
    t.decimal  "clp_to_usd"
    t.decimal  "total"
    t.decimal  "tax"
    t.integer  "order_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "completed_at"
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id", using: :btree
  add_index "payments", ["status"], name: "index_payments_on_status", using: :btree
  add_index "payments", ["type"], name: "index_payments_on_type", using: :btree

  create_table "products", force: true do |t|
    t.string   "sku"
    t.string   "name"
    t.text     "description"
    t.decimal  "buy_price"
    t.decimal  "sell_price"
    t.boolean  "is_active"
    t.integer  "stock"
    t.string   "photo_1"
    t.string   "photo_2"
    t.string   "photo_3"
    t.string   "photo_4"
    t.string   "photo_5"
    t.string   "main_photo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category"
    t.string   "uuid"
    t.string   "slug"
  end

  add_index "products", ["buy_price"], name: "index_products_on_buy_price", using: :btree
  add_index "products", ["category"], name: "index_products_on_category", using: :btree
  add_index "products", ["name"], name: "index_products_on_name", using: :btree
  add_index "products", ["sell_price"], name: "index_products_on_sell_price", using: :btree
  add_index "products", ["sku"], name: "index_products_on_sku", using: :btree
  add_index "products", ["stock"], name: "index_products_on_stock", using: :btree
  add_index "products", ["uuid"], name: "index_products_on_uuid", unique: true, using: :btree

  create_table "shipments", force: true do |t|
    t.integer  "status"
    t.string   "products_ids",              default: [], array: true
    t.integer  "order_id"
    t.integer  "shipping_address_id"
    t.string   "shipping_city"
    t.string   "shipping_town"
    t.text     "shipping_address_address"
    t.string   "shipping_address_number"
    t.text     "shipping_comments"
    t.string   "shipping_receiver_name"
    t.string   "shipping_received_by"
    t.datetime "received_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "shipping_date"
    t.string   "shipping_address_number_2"
  end

  add_index "shipments", ["order_id"], name: "index_shipments_on_order_id", using: :btree
  add_index "shipments", ["shipping_address_id"], name: "index_shipments_on_shipping_address_id", using: :btree
  add_index "shipments", ["status"], name: "index_shipments_on_status", using: :btree

  create_table "shipping_addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "city"
    t.string   "town"
    t.text     "address"
    t.string   "address_number"
    t.text     "comments"
    t.string   "receiver_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_number_2"
    t.string   "contact_phone"
    t.integer  "commune_id"
  end

  add_index "shipping_addresses", ["commune_id"], name: "index_shipping_addresses_on_commune_id", using: :btree
  add_index "shipping_addresses", ["town"], name: "index_shipping_addresses_on_town", using: :btree
  add_index "shipping_addresses", ["user_id"], name: "index_shipping_addresses_on_user_id", using: :btree

  create_table "subscription_months", force: true do |t|
    t.integer  "subscription_id"
    t.integer  "shipment_id"
    t.date     "month"
    t.string   "coffee_beans_ids", default: [], array: true
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscription_months", ["shipment_id"], name: "index_subscription_months_on_shipment_id", using: :btree
  add_index "subscription_months", ["subscription_id"], name: "index_subscription_months_on_subscription_id", using: :btree

  create_table "subscription_plan_entries", force: true do |t|
    t.integer  "subscription_plan_id"
    t.integer  "period_quantity"
    t.decimal  "price",                default: 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscription_plan_entries", ["subscription_plan_id"], name: "index_subscription_plan_entries_on_subscription_plan_id", using: :btree

  create_table "subscription_plans", force: true do |t|
    t.string   "name"
    t.string   "sku"
    t.integer  "coffee_grams"
    t.boolean  "is_active",    default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", force: true do |t|
    t.integer  "user_id"
    t.integer  "subscription_plan_id"
    t.integer  "order_id"
    t.date     "date_from"
    t.date     "date_to"
    t.integer  "months"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "subscription_plan_price"
  end

  add_index "subscriptions", ["date_from"], name: "index_subscriptions_on_date_from", using: :btree
  add_index "subscriptions", ["date_to"], name: "index_subscriptions_on_date_to", using: :btree
  add_index "subscriptions", ["months"], name: "index_subscriptions_on_months", using: :btree
  add_index "subscriptions", ["order_id"], name: "index_subscriptions_on_order_id", using: :btree
  add_index "subscriptions", ["status"], name: "index_subscriptions_on_status", using: :btree
  add_index "subscriptions", ["subscription_plan_id"], name: "index_subscriptions_on_subscription_plan_id", using: :btree
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "test_models", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_active",               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.boolean  "is_admin",                default: false
    t.string   "password_recovery_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_recovery_token"], name: "index_users_on_password_recovery_token", using: :btree
  add_index "users", ["remember_token"], name: "index_users_on_remember_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
