class AddLinkToTweets < ActiveRecord::Migration[6.0]
  def change
    add_column :tweets, :link, :string
  end
end
