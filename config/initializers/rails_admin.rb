RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.authenticate_with do
    authenticate_or_request_with_http_basic('Login required') do |username, password|
      user = User.where(email: username, is_admin: true).first
      user if user&.authenticate(password)
    end
  end

  # Reload config dynamically
  config.parent_controller = ApplicationController.to_s

  config.model 'User' do
    list do
      field :email
      field :name do
        pretty_value do
          path = bindings[:view].show_path(model_name: 'User', id: bindings[:object].id)
          bindings[:view].tag(:a, href: path) << bindings[:object].name
        end
      end
      field :is_admin
    end
  end

  config.model 'Race' do
    list do
      include_all_fields
      exclude_fields :created_at, :updated_at, :description, :initial_lot, :_id
    end
  end

end
