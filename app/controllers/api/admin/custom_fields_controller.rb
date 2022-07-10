class API::Admin::CustomFieldsController < API::Admin::BaseController
  def index
    represent CustomField.all
  end

  def show
    present custom_field
  end

  def create
    present CustomField.create(custom_field_params)
  end

  def update
    custom_field.update(custom_field_params)
    present custom_field
  end

  def destroy
    custom_field.destroy
    head :ok
  end

  private

  def custom_field
    @custom_field ||= CustomField.find(params[:id])
  end

  def custom_field_params
    params.permit(:name, :custom_field_type, :desc, :meta)
  end
end
