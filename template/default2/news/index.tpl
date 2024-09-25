<section class="page news">
    <div class="container">
        <h1 class="content-title">
            Новости
        </h1>
        <hr/>


        <div class="section-new">

            <?php if ($news): ?>

                <div class="row mb-2">

                    <?php foreach ($news as $item): ?>


                        <div class="col-md-6">
                            <div class="card flex-md-row mb-4 box-shadow h-md-250">
                                <div class="card-body d-flex flex-column align-items-start">
                                    <strong class="d-inline-block mb-2"><?php echo $item['title']; ?></strong>
                                    <p class="card-text mb-auto">
                                        <?php echo $item['text']; ?>
                                    </p>

                                    <div class="mt-2 text-muted">
                                        <?php echo date("d.m.Y", $item['date_create']); ?>
                                    </div>
                                </div>
                            </div>
                        </div>
                    <?php endforeach; ?>

                </div>

            <?php else: ?>
                <p>В данный момент новостей отсутствует</p>
            <?php endif; ?>


        </div>
    </div>
</section>