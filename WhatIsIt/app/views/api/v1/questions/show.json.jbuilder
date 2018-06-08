
  json.username @question_username
  json.questionID @question.id
  json.userID @question.user_id
  json.created @question.created_at
  json.updated @question.updated_at
  json.title @question.title
  json.content @question.content
  json.image @question.image.name
   json.answers @question.answers do |answer|

   end

