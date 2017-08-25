
const button = document.querySelector('#button')

button.addEventListener('click', function() {
  const login = document.querySelector('#login')
  const password = document.querySelector('#password')
  
//  ipTbody.innerHTML += `<tr><td>${values.join('</td><td>')}</td><td><button class = "delete" >X</button></td></tr>`
  let address = {ip: values[0], mask: values[1], version: values[2]}
  iptables.addAddress(address)
})