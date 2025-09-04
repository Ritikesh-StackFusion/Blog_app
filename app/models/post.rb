class Post < ApplicationRecord
  has_one_attached :image

  after_commit :sync_to_firebase, on: [:create, :update]
  after_destroy :remove_from_firebase

  def firebase_client
    @firebase_client ||= FirebaseClient.new(
      ENV['FIREBASE_DB_URL'],
      ENV['FIREBASE_DB_SECRET']
    )
  end

  private

	def sync_to_firebase
	  firebase_client.write_data("posts/#{id}", {
	    title: title,
	    content: content,
	    author: author,
	    category: category,
	    tags: tags.is_a?(Array) ? tags : tags.to_s.split(','),
	    #image_url: image.attached? ? Rails.application.routes.url_helpers.rails_blob_url(image, only_path: false) : nil,
	    created_at: created_at,
	    updated_at: updated_at
	  })
	end

  def remove_from_firebase
    firebase_client.delete_data("posts/#{id}")
  end
end
