# Implementasi Visualisasi Data Interaktif pada Data Ketahanan Pangan Indonesia
### astrinariswari.github.io
Project UAS Mata Kuliah Visualisasi Data dan Informasi 2021/2022 \
Astrinariswari Rahmadian P (221910835/3SD1)

## Latar Belakang 
- Pangan merupakan hal yang sangat penting bagi kehidupan manusia dan pertahanan pangan mempunyai pengaruh yang penting. 
- Ketahanan pangan ini disebut sebagai isu multidimesi dan sangat kompleks.
- Angka prevalensi ketidakcukupan pangan (Prevalence of Undernourishment/PoU) nasional naik
- Tidak stabilnya persediaan pangan 
- Keterbatasan data tentang ketahanan pangan membuat masyarakat sulit untuk memantau perkembangan kondisi ketahanan pangan.
- Diperlukan visualisasi data yang interaktif untuk mempermudah masyarakat awam dalam membaca dan memahamin data ketahanan pangan.

## Tujuan Penelitian 
- Untuk mengimplementasikan visualisasi data interaktif data ketahanan pangan yang meliputi data harga rata-rata pangan per minggu, skor Pola Pangan Harapan (PPH), dan Indeks Ketahanan Pangan (IKP).
- Membuat fitur visualisasi yang dapat menampilkan dan membandingkan hasil analisis dalam bentuk dashboard interaktif. 

## Metodologi
### Dataset 
- Data harga rata-rata pangan per Minggu (1 Januari 2020-30 Mei 2022). Dataset ini didapatkan dari halaman https://hargapangan.id/ dengan melakukan filter hanya untuk pasar tradisional, laporan mingguan, dan rentang waktu 1 Januari 2020-30 Mei 2022. (Dataset ini dapat dilihat di folder dataset dengan nama file harga_pangan.xlsx)
- Data Indeks Ketahanan Pangan Indonesia 2021 Menurut Provinsi. Indeks Ketahanan Pangan merupakan suatu indeks yang dibangun berdasarkan sembilan indikator yang digunakan dalam penyusunan IKP merupakan turunan dari tiga aspek ketahanan pangan, yaitu ketersediaan, keterjangkauan dan pemanfaatan pangan. Dataset ini diperoleh dari publikasi Badan Ketahanan Pangan Kementerian Pertanian http://repository.pertanian.go.id/bitstream/handle/123456789/15396/IKP2021-ISBN.pdf?sequence=1&isAllowed=y. (Dataset ini dapat dilihat di folder dataset dengan nama file ikp_per provinsi.xlsx; ikp_tahun ke tahun.xlsx; dan distribusiPerubahanSkorProv.xlsx) 
- Data Skor Pola Pangan Harapan 2021 Menurut Provinsi. Hal ini penting dalam ketahanan pangan Indonesia karena skor PPH digunakan untuk merencanakan kebutuhan konsumsi pangan pada tahun-tahun mendatang. Dataset ini diperoleh dari publikasi Badan Ketahanan Pangan Kementerian Pertanian. (Dataset ini dapat dilihat di folder dataset dengan nama file pph.xlsx) 
- Data 1000 tweets terakhir yang mengandung kata “Ketahanan Pangan”. Mengekstraksi kata-kata yang sering muncul dalah tweets yang mengandung kata "Ketahanan Pangan"

### Langkah-langkah pengerjaan
### Pre-processing
Preprocessing and data transformation, peneliti akan melakukan pengumpulan data yang diperlukan dalam penelitian ini. Data yang dikumpulkan antara lain harga pangan, skor Pola Pangan Harapan (PPH), Indeks Ketahanan Pangan (IKP), dan data twitter. Setelah data terkumpul, peneliti melakukan pengolahan data Indeks Ketahanan Pangan, dan skor Pola Pangan Harapan dengan menggunakan Microsoft Excel.

### Pengolahan
#### Text mining
Berikut source code untuk Text Mining dengan menggunakan software R
##### Load Package
```{r}
library(rtweet)
library(ggplot2)
library(dplyr)
library(tm)
library(wordcloud)
```
##### Membuat Token untuk mengakses twitter
```{r}
get_token()
```
##### Mencari Tweets 
```{r}
rstat_tweets <- search_tweets(q="Ketahanan Pangan", n= 1000)

head(rstat_tweets, n=5)
textdata <- head(rstat_tweets$text)
textdata <- rstat_tweets$text
tweet_doc <- Corpus(VectorSource(textdata))
```
##### Membersihkan corpus
```{r}
tweet_doc <- tm_map(tweet_doc, content_transformer(tolower))
tweet_doc <- tm_map(tweet_doc, removeNumbers)
tweet_doc <- tm_map(tweet_doc, removeWords)
tweet_doc <- tm_map(tweet_doc, removePunctuation)
tweet_doc <- tm_map(tweet_doc, stripWhitespace)
```
##### Convert corpus dengan berbagai manipulasi 
```{r}
dtm <- TermDocumentMatrix(tweet_doc)
m <- as.matrix(dtm)
v <- sort(rowSums(m), decreasing = TRUE)
d <- data.frame(frequency=v)
d <- data.frame(word=names(v), frequency=v)
head(d,10)
```
##### Plot untuk data yang memiliki frekuensi kemunculan tinggi
```{r}
barplot(d[1:15,]$frequency, las=2, names.arg = d[1:15,]$word, col = "salmon", 
        main = "Top 15 Most Frequent Words", ylab = "word frequencies" )
```
##### Membuat wordcloud
```{r}
set.seed(1234)
wordcloud(words=d$word, freq = d$frequency, min.freq = 5, max.words = 1000, 
          random.order = F, colors = brewer.pal(8, "Dark2"), rot.per = 0.3)
```
#### Visualisasi Data Interaktif
Setelah data melewati pre-processing dan transformation serta pengolahan, data siap untuk divisualisasikan. Dalam melakukan visualisasi data di bantu dengan menggunakan software Tableau. Penyimpanan project visualisasi ini di tableau public sehingga pengguna dapat melihat langsung pada link berikut. 
https://public.tableau.com/app/profile/astrinariswari

#### Dashboard 
Karena penelitian ini ingin membuat dashboard visualisasi data interaktif pada ketahanan pangan berbasis web, peneliti melanjutkan proses pembuatan dashboard dengan menggunakan html dan css. 

## Hasil
Hasil dari penelitian ini yaitu dihasilkan dashboard visualisasi data interaktif pada data ketahanan pangan berbasis website. Dalam dashboard visualisasi data yang dibangun terdiri dari menu: 
- about : informasi mengenai ketahanan pangan dan visualisasi data hasil text mining data twitter
- ketahanan pangan : visualisasi data interaktif data indeks ketahanan pangan
- harga pangan : visualisasi data interaktif data harga rata-rata pangan komoditas per minggu (1 Januari 2020-30 Mei 2022)
- skor PPH : visualisasi data interakif data skor Pola Pangan Harapan (PPH) Indonesia tahun 2021
Adapun website dapat dikunjungi pada link berikut ini : https://astrinariswari.github.io/index.html 

## Kesimpulan
Dashboard visualisasi data interaktif pada ketahanan pangan berbasis website telah berhasil dibangun pangan yang terdiri dari data Indeks Ketahanan Pangan, skor Pola Pangan Harapan (PPH), harga rata-rata pangan komoditas per minggu, dan data twitter  melalui 5 jenis visualisasi data interaktif yaitu Bar Chart, Line Chart, Pie Chart, Choropleth Map, dan Word Cloud.
