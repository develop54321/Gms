
"use strict";

(function($) {
	
    //data-table
    $('#tasks-table').DataTable({
        language: {
            searchPlaceholder: 'Search...',
            sSearch: '',
        },
        pageLength: 10,
    });

    //file upload
    $('document').on("ready", function(){
  
        var $file = $('#task-file-input'),
            $label = $file.next('label'),
            $labelText = $label.find('span'),
            $labelRemove = $('i.remove'),
            labelDefault = $labelText.text();
        
        // on file change
        $file.on('change', function(event){
          var fileName = $file.val().split( '\\' ).pop();
          if( fileName ){
            $labelText.text(fileName);
            $labelRemove.show();
          }else{
            $labelText.text(labelDefault);
            $labelRemove.hide();
          }
        });
        
        // Remove file   
        $labelRemove.on('click', function(event){
          $file.val("");
          $labelText.text(labelDefault);
          $labelRemove.hide();
          console.log($file)
        });
    })

    // Select2 
	$('.select2').select2({
		minimumResultsForSearch: Infinity
	});
    
    //select2 with indicator
    function selectStatus (status) {
        if (!status.id) { return status.text; }
        var $status = $(
            '<span class="status-indicator projects">' + status.text + '</span>',
        );
        var $statusText = $status.text().split(" ").join("").toLowerCase();
        if($statusText === "inprogress"){
            $status.addClass("in-progress");
        }
        else if($statusText === "onhold"){
        $status.addClass("on-hold");
        }
        else if($statusText === "completed"){
        $status.addClass("completed");
        }
        else{
        $status.addClass("empty");
        }
        return $status;
    };
    
    
    $(".select2-status-search").select2({
        templateResult: selectStatus,
        templateSelection: selectStatus,
        escapeMarkup: function(s) { return s; }
    });

})(jQuery);

//todo task
const subTaskContainer = document.querySelector('.sub-list-container');

if(subTaskContainer){

    const subTaskElement = document.querySelector('.sub-list-item');
    const addSubTaskBtn = document.querySelector('#addTask');
    const subTaskInput = document.querySelector('#subTaskInput');
    const errorNote = document.querySelector('#errorNote');
    const deleteAllTasks = document.querySelector('#deleteAllTasks');
    const completedAllBtn = document.querySelector('#completedAll');

    
    setTimeout(() => {
        setInterval(() => {
            const deleteBtn = document.querySelectorAll('.delete-main');
            for(let i = 0; i < deleteBtn.length; i++){
                deleteBtn[i].addEventListener('click', deleteSubTask);
            }
        }, 10);
    }, 1);
        
    //delete task
    function deleteSubTask($e){
        subTaskContainer.removeChild($e.target.parentElement);
    }
    
    //mark all as completed vice verca
    var count = 0;

    function markAllCompleted(){
        var allTasks = subTaskContainer.children;
    
        if(count % 2 != 0){
            for(let i = 0; i < allTasks.length; i++){
    
                allTasks[i].classList.remove('task-completed');
            }
        }
        else{
            for(let i = 0; i < allTasks.length; i++){
    
                allTasks[i].classList.add('task-completed');
            }
        }
        count++;
    }
    
    //remove all tasks
    function removeAllTasks(){
        subTaskContainer.innerHTML = ' ';
    }

    //add new task
    var taskCopy = subTaskElement.cloneNode(true);

    function addNewTask(){
        errorNote.innerText = "";
        var newSubTask = taskCopy.cloneNode(true);
        newSubTask.classList.remove('task-completed')
        var newTaskText = subTaskInput.value;
        if(newTaskText.length !== 0){
            subTaskContainer.appendChild(newSubTask);
            newSubTask.children[0].children[1].innerText = newTaskText;
            subTaskInput.value = "";
        }
        else{
        errorNote.innerText = "Please Enter Valid Input";
        }
    }
    
    //mark task as completed
    function taskCompleted($e){
        var currentSubList = $e.target;
        var subListParent = currentSubList.parentElement.parentElement;
    
        if(subListParent.classList.contains('task-completed')){
            subListParent.classList.remove('task-completed');
        }
        else{
            subListParent.classList.add('task-completed');
        }
    }
    
    completedAllBtn.addEventListener('click', markAllCompleted); // mark all completed
    deleteAllTasks.addEventListener('click', removeAllTasks);   //delete all tasks
    addSubTaskBtn.addEventListener('click', addNewTask);    //create new task
}

//reply to a comment/review
function replay() {

    let replayButtom = document.querySelectorAll('.reply a')

    // Creating Div
    let Div = document.createElement('div')
    Div.setAttribute('class', "comment mt-5 d-grid w-60")

    // creating textarea
    let textArea = document.createElement('textarea')
    textArea.setAttribute('class', "form-control")
    textArea.setAttribute('rows', "5")
    textArea.innerText = "Your Comment";

    // creating Cancel buttons
    let cancelButton = document.createElement('button');
    cancelButton.setAttribute('class', "btn btn-danger");
    cancelButton.innerText = "Cancel";

    let buttonDiv = document.createElement('div')
    buttonDiv.setAttribute('class', "btn-list ms-auto mt-2")

    // Creating submit button
    let submitButton = document.createElement('button');
    submitButton.setAttribute('class', "btn btn-success ms-3");
    submitButton.innerText = "Submit";

    // appending text are to div
    Div.append(textArea)
    Div.append(buttonDiv);
    buttonDiv.append(cancelButton);
    buttonDiv.append(submitButton);

    replayButtom.forEach((element, index) => {

        element.addEventListener('click', () => {
            let replay = $(element).parent()
            replay.append(Div)

            cancelButton.addEventListener('click', () => {
                Div.remove()
            })
        })
    })
}
replay()