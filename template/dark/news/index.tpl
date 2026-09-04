<section class="page news">
    <div class="container">
        <h1 class="content-title">
            Новости
        </h1>
        <hr/>


        <div class="section-new">

            <?php if ($news): ?>

                <div class="news-grid">

                    <?php foreach ($news as $item): ?>
                        <div class="news-card">
                            <h3><?php echo $item['title']; ?></h3>
                            <p><?php echo $item['text']; ?></p>
                            <div class="date"><i class="fa fa-clock-o"></i> <?php echo date("d.m.Y", $item['date_create']); ?></div>
                        </div>
                    <?php endforeach; ?>

                </div>

            <?php else: ?>
                <div class="empty-hint"><i class="fa fa-newspaper-o"></i>В данный момент новостей отсутствует</div>
            <?php endif; ?>


        </div>
    </div>
</section>