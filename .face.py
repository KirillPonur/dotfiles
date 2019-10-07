import requests
import vk_api


def main():
    login = '+79601853181',
    photo='photo_400_orig'
    
    vk_session = vk_api.VkApi(login=login,
        token='a4a8345e21df6aa09dedb182119617b99be8206a1481d036d5cc490b959931619608ee0a46929f659480c')

    try:
        vk_session.auth(token_only=True)
    except vk_api.AuthError as error_msg:
        print(error_msg)
        return

    vk = vk_session.get_api()
    response = vk.users.get(fields=photo)  # Используем метод wall.get
    url = str(response[0][photo])
    r = requests.get(url, allow_redirects=True)
    open('.face', 'wb').write(r.content)

if __name__ == '__main__':
    main()