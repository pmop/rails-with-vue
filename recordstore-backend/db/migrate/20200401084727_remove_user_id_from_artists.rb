class RemoveUserIdFromArtists < ActiveRecord::Migration[6.0]
  def up
    remove_column 'artists', 'user_id'

    remove_column 'records', 'user_id'
  end

  def down
    add_column 'artists', 'user_id'
    add_index 'artists', 'user_id'


    add_column 'records', 'user_id'
    add_index 'records', 'user_id'
  end
end
