class Tables {

  constructor() {
    this.result = document.querySelector('main section table tbody')
    //this.ipTbody = ipTbody
  }

  get_data(){
    const url = 'http://localhost:8080/src/project/home/home.php'

    fetch(url)
      .then(res => res.json())
        .then(info =>{
        let lines = ""
        let max=info.length
        let j=0;

        for( let i of Object.values(info)){
          console.log(i)
          j++
          if(j<max){
            lines += `<tr><td>${i[0]}</td><td>${i[1]}</td><td>${i[2]}</td><td>${i[3]}</td></tr>`
          }
        }
        this.result.innerHTML = lines
        })
  }

  render(){
    this.get_data()
  }
}

const table = new Tables();
table.render()