class BankinController < ApplicationController

  def initialize
    super
    @headers = {
        'bankin-version': "2019-02-18",
        'Client-Id': "01d9b9a2c3d8483ba22310bf161fa5c8",
        'Client-Secret': "jFs50V7HiNAfPXLNVAgZagaLurhgS3zivdMRlUgHgHT8K6jjUENv3L3fynLtRhuD",
        'Content-Type': 'application/json'
      }


      @bankin_instance = BankinApi.new
    end

    def new_user
      @credentials = {
          email: current_user.email,
          password: "password123456"
        }
      @data0 = @bankin_instance.create_b(@headers, @credentials)
      skip_authorization
      authenticate_user
      synchronize_item
    end

  def list_users
    BankinApi.new.list_b(@headers)
  end

  def authenticate_user
    @credentials = {
          email: current_user.email,
          password: "password123456"
        }
    @data1 = @bankin_instance.authenticate_b(@headers, @credentials)
    @access_token = "Bearer #{@data1["access_token"]}"
  end

  def synchronize_item
    @data2 = @bankin_instance.sync_item_b(@headers, @access_token)
    redirect_to @data2["redirect_url"]
  end

  def connect_item
    authenticate_user
    @data3 = @bankin_instance.connect_item_b(@headers, @access_token)
  end

  def list_items
    data4 = @bankin_instance.list_items_b(@headers, @access_token)
  end

  def list_account
    connect_item
    @data5 = @bankin_instance.list_accounts_b(@headers, @access_token)

    @account_id = @data5["resources"][0]["id"]
    # PROBLEME AVEC L'INTERPOLLATION
    create_account
  end

  def get_account
    list_account
    @data6 = @bankin_instance.get_account_b(@headers, @access_token)
  end

  def list_transactions
    get_account
    @company = Company.find(current_user.company_id)
    @data8 = @bankin_instance.list_categories_b(@headers)

    @data7 = @bankin_instance.list_transactions_b(@headers, @access_token)
    @data7["resources"].each do |trans|
      trans["category"] = @bankin_instance.single_category_b(@headers, trans["category"]["id"])
    end
    skip_authorization

  end


  def list_categories
  end

  def create_account
    @company = Company.find(current_user.company_id)
    uuid_accounts = []
    @company.accounts.each do |account|
      uuid_accounts << account[:bankin_uu_id]
    end

    @data5["resources"].each do |account|

      if !uuid_accounts.include?(account["id"])
        Account.new(iban: account["iban"], account_name: account["name"], company_id: current_user.company_id, bankin_uu_id: account["id"].to_i, swift: 000000).save
      end
    end
  end

end
