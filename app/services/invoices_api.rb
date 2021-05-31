class InvoicesApi
  BASE_URL = "https://api.mindee.net/v1/products/mindee/invoices/v2/predict".freeze

  def initialize(invoice)
    @invoice = invoice
    @token = ENV['MINDEE_TOKEN']
  end

  def call(file)
    response = HTTP.auth("Token #{@token}").post(BASE_URL, form: { document: base64_image(file) })
    result = response.parse
    # raise
    @invoice.date = Date.parse(result["document"]["inference"]["pages"][0]["prediction"]["date"]["value"])
    @invoice.issuer = result["document"]["inference"]["pages"][0]["prediction"]["supplier"]["value"]
    @invoice.total_amount = result["document"]["inference"]["pages"][0]["prediction"]["total_incl"]["value"]
    @invoice.net_amount = result["document"]["inference"]["pages"][0]["prediction"]["total_excl"]["value"]

    if result["document"]["inference"]["pages"][0]["prediction"]["taxes"] != []
      @invoice.tax_amount = result["document"]["inference"]["pages"][0]["prediction"]["taxes"][0]["value"]
      @invoice.vta = result["document"]["inference"]["pages"][0]["prediction"]["taxes"][0]["rate"]
    else
      @invoice.tax_amount = @invoice.total_amount - @invoice.net_amount
    end

    #LOGIC TO FILL THE INVOICE
    return @invoice
  end

  private

  def base64_image(file)
    Base64.encode64(file.read)
  end
end


# InvoicesApi.new.call("....") # => JSON
