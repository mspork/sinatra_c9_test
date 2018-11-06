
%w(/ /orders).each do |path|
  get path do
    @orders = Order.all
    erb :'orders/index'
  end
end


%w(/new /orders/new).each do |path|
  get path do
    @title = 'New Order'
    @order  = Order.new
    erb :'orders/new'
  end
end


post '/orders' do
  if params[:order]
    @order           = Order.new(params[:order])
    # if params[:order][:picture] && params[:order][:picture][:filename] && params[:order][:picture][:tempfile]
    #   filename      = params[:order][:picture][:filename]
    #   @order.picture = filename
    #   file          = params[:order][:picture][:tempfile]
    #   FileUtils.copy_file(file.path,"files/#{@order.picture}")
    # end
    if @order.save
      redirect '/orders'
    else
      erb :'orders/new'
    end
  else
    erb :'orders/new'
  end
end

get '/orders/:id' do
  @order = Order.find(params[:id])
  erb :'orders/show'
end

helpers do
  def delete_order_button(order_id)
    erb :'orders/_delete_order_button', locals: { order_id: order_id }
  end
end

delete '/orders/:id' do
  Order.find(params[:id]).destroy
  redirect '/orders'
end

get '/orders/:id/edit' do
  @order = Order.find(params[:id])
  erb :'orders/edit'
end

put '/orders/:id' do
  # if params[:order].try(:[], :picture)
  #   file      = params[:order][:picture][:tempfile]
  #   @filename = params[:order][:picture][:filename]
  # end

  @order = Order.find(params[:id])

  if @order.update_attributes(params[:order])
    # if @filename
    #   @order.picture = @filename
    #   @order.save
    #   File.open("./files/#{@filename}", 'wb') do |f|
    #     f.write(file.read)
    #   end
    # end
    redirect "/orders/#{@order.id}"
  else
    erb :'orders/edit'
  end
end