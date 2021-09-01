<div class="row">
    <div class="col-sm-12">
        <h4 class="page-title">Новости</h4>
        <ol class="breadcrumb">
            <li><a href="/control">Главная</a></li>
            <li class="active">Новости</li>
        </ol>
    </div>
</div>


<div class="col-sm-12">

    <div class="card-box">
        <h4 class="m-t-0 header-title"><b>Новости</b></h4>
        <p class="text-muted m-b-30 font-12">Страницы по умолчанию сортируется по дате</p>
        <a href="/control/news/add" style="float: right;" class="btn btn-inverse btn-custom btn-rounded waves-effect waves-light btn-xs">Опубликовать новый пост</a>



        <table class="table table table-hover m-0">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Заголовок</th>
                <th scope="col">Дата добавления</th>

                <th scope="col"></th>
            </tr>
            </thead>
            <tbody>
            <?php foreach($news as $row):?>

            <tr id="post<?php echo $row['id'];?>">
                <td><?php echo $row['id'];?></td>

                <td>
                    <a style="white-space: nowrap;overflow: hidden;text-overflow: ellipsis;display: block;width: 500px;" href="/news" target="_blank"><?php echo $row['title'];?></a></td>
                <td>
                    <?php echo date("d:m:Y [H:i]", $row['date_create']);?>
                </td>

                <td>
                    <a href="/control/news/edit?id=<?=$row['id'];?>" class="text-muted" title="Изменить пост"><i class="fa fa-pencil"></i></a>
                    <a href="#" onclick="remove(<?=$row['id'];?>); return false;" class="text-muted" title="Удалить пост"><i class="fa fa-trash"></i></a>
                </td>
            </tr>
            <?php endforeach;?>

            </tbody>
        </table>

        <?php if(!isset($action)):?>
        <div class="pagination">
            <?php foreach($ViewPagination as $p):?>
            <?php echo $p[0];?>
            <?php endforeach;?>
        </div>
        <?php endif;?>



    </div>
</div>

<script>
    function remove(id){
        if(confirm("Вы действительно хотите удалить?")){
            $.ajax({
                url: "/control/news/remove",
                data: {'id':id},
                success: function(){
                    $('#post'+id+'').hide(300);
                }
            });
        }
    }
</script>