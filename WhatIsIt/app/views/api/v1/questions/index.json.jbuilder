json.array! @questions do |question|
    question.(question, 
      :id, 
      :title, 
      :content, 
      :user_id,
      :created_at, 
      :updated_at,
    )

end