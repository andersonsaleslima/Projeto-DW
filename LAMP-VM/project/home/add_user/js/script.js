const button = document.querySelector('button')
const result = document.querySelector('#result')

button.addEventListener('click', function() {
  const login = document.querySelector('#login')
  const password = document.querySelector('#password')

  let url = `../add_user.php?name_of_user=${login.value}&password=${password.value}`;

  console.log(url)

  fetch(url)
      .then(res => res.json())
        .then(info => {
        	this.result.innerHTML = info.status
        	console.log(info)
        })
})