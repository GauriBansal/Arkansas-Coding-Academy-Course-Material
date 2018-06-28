
var toVisitList = [];

function Todo(placeName, country) {

    var self = this;

    self.placeName = placeName;
    self.country = country;
    self.isVisited = false;
}

function addTodo() {

    //textBox = "todoName"
    //unorderdList = "todoItems"

    //get the text from the textbox
    var textdata = document.getElementById("todoName").value;
    var todoList = textdata.split(",");

    var placeName = todoList[0];
    var country = todoList[1];
    console.log(todoList);

    //create new instance of Todo() and pass the text from the textbox
    var todoItems = new Todo(placeName, country);
    
    //push that new instance of the Todo() to the array
    toVisitList.push(todoItems);

    //create a li element and set it's text to the new instance of the Todo().name   
    var li1 = document.createElement("li");
    li1.className = "col-6"
    li1.textContent = todoItems.placeName.toUpperCase();

    //create another li element and set it's text to the new instance of the Todo().name
    var li2 = document.createElement("li");
    li2.className = "col-6"
    li2.textContent = todoItems.country.toUpperCase();
    li2.style.listStyleType = 'none';

    //check the isvisited counter and set styles
    if (!todoItems.isVisited){
        li1.className += ' text-success';
        li2.className += ' text-success';
        li1.style.listStyleType = 'square';
        todoItems.isVisited = true;
    } else {
        li1.className += ' text-danger';
        li2.className += ' text-danger';        
    }

    //add the li element to the DOM
    var liParent = document.getElementById("todoItems");
    liParent.className = 'row';
    liParent.appendChild(li1);
    liParent.appendChild(li2);

    //clear out the textbox
    document.getElementById("todoName").value = "";
    document.getElementById("todoName").focus();

    // todoItems.isVisited.watch( 'isVisited', function( isVisited, oldval, newval ) {
    //     alert( 'the property todoItems.isVitited::' + isVisited +' changed from ' + false + ' to ' + true );
    // });
    
    
    // myObj.p = 'hello'; //alerts: the property myObj::p changed from undefined to hello
    // myObj.p = 'world'; //alerts: the property myObj::p changed from hello to world
    
    // // stop watching
    // myObj.unwatch('p');
}
