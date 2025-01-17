--: Chat(response?)


--! new_chat
INSERT INTO chats 
    (user_id, organisation_id, prompt_id, user_request, prompt)
VALUES
    (:user_id, :organisation_id, :prompt_id, :user_request, :prompt);
    
--! update_chat
UPDATE chats 
SET 
    response = :response,
    status = :chat_status
WHERE
    user_id = current_app_user()
AND 
    id = :chat_id
AND     
    organisation_id IN (SELECT id FROM organisations WHERE user_id = current_app_user());
    
--! update_prompt
UPDATE chats 
SET 
    prompt = :prompt
WHERE
    user_id = current_app_user()
AND 
    id = :chat_id
AND     
    organisation_id IN (SELECT id FROM organisations WHERE user_id = current_app_user());

--! chats : Chat
SELECT
    id,
    user_id, 
    organisation_id, 
    user_request,
    prompt,
    prompt_id,
    (SELECT name FROM models WHERE id IN (SELECT model_id FROM prompts WHERE id = prompt_id)) as model_name,
    response,
    created_at,
    updated_at
FROM 
    chats
WHERE
    user_id = current_app_user()
AND 
    organisation_id IN (SELECT id FROM organisations WHERE user_id = current_app_user())
ORDER BY updated_at;

--! chat_history : Chat
SELECT
    id,
    user_id, 
    organisation_id, 
    user_request,
    prompt,
    prompt_id,
    (SELECT name FROM models WHERE id IN (SELECT model_id FROM prompts WHERE id = prompt_id)) as model_name,
    response,
    created_at,
    updated_at
FROM 
    chats
WHERE
    user_id = current_app_user()
AND 
    status = 'Success'
AND 
    organisation_id IN (SELECT id FROM organisations WHERE user_id = current_app_user())
ORDER BY updated_at DESC
LIMIT :limit;

--! chat : Chat
SELECT
    id,
    user_id, 
    organisation_id, 
    user_request,
    prompt,
    prompt_id,
    (SELECT name FROM models WHERE id IN (SELECT model_id FROM prompts WHERE id = prompt_id)) as model_name,
    response,
    created_at,
    updated_at
FROM 
    chats
WHERE
    user_id = current_app_user()
AND
    id = :chat_id
AND 
    organisation_id IN (SELECT id FROM organisations WHERE user_id = current_app_user())
ORDER BY updated_at;