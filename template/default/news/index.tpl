<div class="content">
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="/">Главная</a></li>
      <li class="breadcrumb-item active" aria-current="page">Новости</li>
    </ol>
  </nav>

    <?php if ($news):?>

    <div class="row mb-2">

      <?php foreach($news as $item):?>



      <div class="col-md-6">
        <div class="card flex-md-row mb-4 box-shadow h-md-250">
          <div class="card-body d-flex flex-column align-items-start">
            <strong class="d-inline-block mb-2 text-primary"><?php echo $item['title'];?></strong>
            <div class="mb-1 text-muted">
              <?php echo date("d.m.Y", $item['date_create']);?>
            </div>
            <p class="card-text mb-auto">
              <?php echo $item['text'];?>
            </p>
          </div>
        </div>
      </div>
      <?php endforeach;?>

    </div>

    <?php else:?>
    <p>В данный момент новостей отсутствует</p>
    <?php endif;?>


  </div>
</section>