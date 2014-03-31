class CreateSongLib < ActiveRecord::Migration

  def change

   create_table :libraries do |t|
      t.decimal :metal_percent
      t.string  :md5_hash
      t.integer :total_artists
      t.integer :total_songs
      t.integer :total_metal_songs
      t.string  :your_favorite_genre
      t.string  :avg_song_length
      t.integer :total_unknown_genre_songs
      t.integer :total_crapy_songs
      t.string  :user_metal_cred
      t.string  :user_cred_pic
      t.float  :longitude
      t.float  :latitude
      t.timestamps
    end
  end

end