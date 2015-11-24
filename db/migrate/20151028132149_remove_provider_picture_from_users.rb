class RemoveProviderPictureFromUsers < ActiveRecord::Migration
  def change
    User.where.not(provider_picture: nil).each do |user|
      user.picture = user.provider_picture.gsub('http', 'https')
    end
    remove_column :users, :provider_picture, :string
  end
end
