class BankinController < ApplicationController

  def initialize
    @headers = {
        'bankin-version': "2019-02-18",
        'Client-Id': "01d9b9a2c3d8483ba22310bf161fa5c8",
        'Client-Secret': "jFs50V7HiNAfPXLNVAgZagaLurhgS3zivdMRlUgHgHT8K6jjUENv3L3fynLtRhuD",
        'Content-Type': 'application/json'
      }

    @credentials = {
        email: "test@counti.fr",
        password: "password123456"
      }

    @bankin_instance = BankinApi.new
  end

  def new_user
    data0 = @bankin_instance.create_b(@headers, @credentials)
    raise
  end

  def list_users
    BankinApi.new.list_b(@headers)
  end

  def authenticate_user
    data1 = @bankin_instance.authenticate_b(@headers, @credentials)
    @access_token = "Bearer #{data1["access_token"]}"
  end

  def synchronize_item
    data2 = @bankin_instance.sync_item_b(@headers, @access_token)
  end

  def connect_item
    authenticate_user
    data3 = @bankin_instance.connect_item_b(@headers, @access_token)
  end

  def list_items
    data4 = @bankin_instance.list_items_b(@headers, @access_token)
  end

  def list_account
    connect_item
    @data5 = @bankin_instance.list_accounts_b(@headers, @access_token)

    @account_id = @data5["resources"][0]["id"]
    # PROBLEME AVEC L'INTERPOLLATION
  end

  def get_account
    list_account
    @data6 = @bankin_instance.get_account_b(@headers, @access_token)
  end

  def list_categories
  end

  def list_transactions
    get_account
    @data8 = @bankin_instance.list_categories_b(@headers)

    @data7 = @bankin_instance.list_transactions_b(@headers, @access_token)
    @data7["resources"].each do |trans|
      trans["category"] = @bankin_instance.single_category_b(@headers, trans["category"]["id"])
    end
    skip_authorization
  end


end
