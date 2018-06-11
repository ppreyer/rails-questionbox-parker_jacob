  json.questions @questions do |question|
   json.id question.id
   json.userID question.user_id
   json.username User.find(question.user_id).username
   json.created_at question.created_at
   json.updated_at question.updated_at
   json.title question.title
   json.content question.content
   json.image_url question.image_url
  end
