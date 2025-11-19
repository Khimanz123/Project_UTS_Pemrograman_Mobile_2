import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';

// Provider untuk menyimpan daftar film favorit (wishlist)
final favoriteProvider = StateProvider<List<String>>((ref) => []);

// Provider untuk teks pencarian
final searchQueryProvider = StateProvider<String>((ref) => "");

// Provider untuk genre yang sedang dipilih
final genreProvider = StateProvider<String>((ref) => "All");

// Data Model Movie dengan rating & description
class Movie {
  final String title;
  final String image;
  final String genre;
  final double rating;
  final String description;

  Movie(
    this.title,
    this.image,
    this.genre, {
    required this.rating,
    required this.description,
  });
}

// =======================
// DATA MY LIST
// =======================
final myList = [
  Movie(
    "Jurassic World",
    "assets/images/film1.png",
    "Action",
    rating: 4.5,
    description:
        "Sekelompok ilmuwan dan pengunjung menghadapi kekacauan ketika dinosaurus hasil rekayasa genetika melarikan diri dari taman hiburan modern.",
  ),
  Movie(
    "Home Alone",
    "assets/images/film2.png",
    "Comedy",
    rating: 4.6,
    description:
        "Seorang bocah tertinggal sendirian di rumah saat keluarganya pergi liburan dan harus menghadapi dua pencuri konyol dengan serangkaian jebakan kreatif.",
  ),
  Movie(
    "World War Z",
    "assets/images/film3.png",
    "Thriller",
    rating: 4.0,
    description:
        "Seorang mantan penyelidik PBB berusaha menemukan sumber wabah global yang mengubah manusia menjadi makhluk agresif agar dapat mencegah kiamat.",
  ),
  Movie(
    "Deadpool",
    "assets/images/film4.png",
    "Action",
    rating: 4.4,
    description:
        "Antihero sarkastik dengan kemampuan penyembuhan super membalas para yang menghancurkan hidupnya dengan humor hitam dan aksi brutal.",
  ),
  Movie(
    "The Long Walk",
    "assets/images/film5.png",
    "Drama",
    rating: 3.9,
    description:
        "Drama emosional tentang perjalanan panjang dan ujian hidup seorang pria yang berusaha merebut kembali mimpi dan hubungan yang hilang.",
  ),
  Movie(
    "Fast & Furious",
    "assets/images/film6.png",
    "Action",
    rating: 4.2,
    description:
        "Serangkaian balapan jalanan, persahabatan, dan misi berbahaya yang dipenuhi aksi kendaraan ekstrim dan kejar-kejaran tak terlupakan.",
  ),
  Movie(
    "Beauty and The Beast",
    "assets/images/film7.png",
    "Romance",
    rating: 4.3,
    description:
        "Kisah cinta klasik antara seorang wanita penuh keberanian dan pangeran yang dikutuk menjadi makhluk mengerikan, dipenuhi musik dan keajaiban.",
  ),
  Movie(
    "Coco",
    "assets/images/film8.png",
    "Animation",
    rating: 4.8,
    description:
        "Seorang anak muda bermimpi menjadi musisi dan melakukan perjalanan ke Alam Orang Mati untuk menemukan sejarah keluarganya dan arti keluarga sejati.",
  ),
  Movie(
    "Up",
    "assets/images/film9.png",
    "Animation",
    rating: 4.7,
    description:
        "Seorang kakek petualang mengikat ribuan balon ke rumahnya untuk mengejar impian perjalanan, tak sengaja membawa seorang anak penjual permen dalam petualangan yang hangat.",
  ),
  Movie(
    "Harry Potter",
    "assets/images/film10.png",
    "Fantasy",
    rating: 4.6,
    description:
        "Seorang anak yatim piatu menemukan dirinya di dunia sihir, menghadapi misteri beserta pertemanan dan pertarungan melawan kegelapan.",
  ),
  Movie(
    "Avatar",
    "assets/images/film11.png",
    "Sci-Fi",
    rating: 4.5,
    description:
        "Seorang mantan marinir dikirim ke planet Pandora dan terpecah antara tugas dan ikatan dengan suku pribumi yang ia pelajari, memunculkan pertanyaan tentang kolonialisme dan alam.",
  ),
  Movie(
    "Joker",
    "assets/images/film12.png",
    "Drama",
    rating: 4.4,
    description:
        "Kisah asal-usul seorang komedian gagal yang mengalami penurunan mental dan berubah menjadi ikon kekerasan dan kekacauan di kota Gotham.",
  ),
];

// =======================
// DATA TOP PICKS
// =======================
final topPicks = [
  Movie(
    "Titanic",
    "assets/images/film13.png",
    "Romance",
    rating: 4.8,
    description:
        "Epos romantis di atas kapal mewah yang tenggelam; kisah cinta yang melintasi kelas sosial dan takdir tragis.",
  ),
  Movie(
    "The Meg",
    "assets/images/film14.png",
    "Action",
    rating: 3.6,
    description:
        "Tim penyelamat harus menghadapi hiu purba raksasa ketika ancaman bawah laut kembali muncul dan membahayakan para penyelam serta kapal riset.",
  ),
  Movie(
    "Inception",
    "assets/images/film15.png",
    "Sci-Fi",
    rating: 4.7,
    description:
        "Seorang pencuri memasuki mimpi orang lain untuk mencuri atau menanamkan ide—kisah penuh lapisan, teka-teki, dan aksi berpacu dengan waktu.",
  ),
  Movie(
    "Jumanji",
    "assets/images/film16.png",
    "Adventure",
    rating: 4.1,
    description:
        "Permainan papan mistis mengirim pemain ke dunia penuh bahaya dan petualangan; mereka harus menyelesaikan permainan untuk pulang.",
  ),
  Movie(
    "Hulk",
    "assets/images/film17.png",
    "Action",
    rating: 3.8,
    description:
        "Seorang ilmuwan yang berubah menjadi raksasa hijau ketika emosinya tidak terkendali berjuang untuk menerima sisi destruktif kekuatannya.",
  ),
  Movie(
    "Captain America",
    "assets/images/film18.png",
    "Action",
    rating: 4.3,
    description:
        "Seorang prajurit bermoral berubah menjadi pahlawan super berperisai yang memimpin melawan ancaman totaliter dalam era peperangan dan setelahnya.",
  ),
  Movie(
    "Avengers: Endgame",
    "assets/images/film19.png",
    "Action",
    rating: 4.7,
    description:
        "Para pahlawan berkumpul untuk memperbaiki konsekuensi pertempuran besar melawan ancaman kosmik—epik, emosional, penuh pengorbanan.",
  ),
  Movie(
    "The Batman",
    "assets/images/film20.png",
    "Action",
    rating: 4.2,
    description:
        "Versi gelap detektif Batman saat ia menyelidiki korupsi di Gotham dan melawan kriminal bersandiwara dalam suasana noir yang tegang.",
  ),
  Movie(
    "Toy Story 4",
    "assets/images/film21.png",
    "Animation",
    rating: 4.3,
    description:
        "Mainan-mainannya kembali dalam petualangan baru yang mengeksplorasi makna rumah, persahabatan, dan menemukan tujuan baru.",
  ),
  Movie(
    "Spiderman",
    "assets/images/film22.png",
    "Action",
    rating: 4.4,
    description:
        "Remaja bersimbah tanggung jawab menjadi pahlawan berkekuatan laba-laba, menghadapi musuh dan dilema keseimbangan hidup normal vs superhero.",
  ),
  Movie(
    "Finding Nemo",
    "assets/images/film23.png",
    "Animation",
    rating: 4.8,
    description:
        "Perjalanan seekor ayah mencari anaknya yang hilang di lautan luas, penuh humor, hati, dan pelajaran tentang keberanian.",
  ),
  Movie(
    "Cars",
    "assets/images/film24.png",
    "Animation",
    rating: 4.0,
    description:
        "Kisah mobil balap yang belajar arti persahabatan dan rendah hati ketika terdampar di kota kecil, berubah menjadi pengalaman yang menginspirasi.",
  ),
];

void main() {
  runApp(const ProviderScope(child: MovieApp()));
}

class MovieApp extends StatelessWidget {
  const MovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List App',
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      ),
      home: const MovieHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MovieHomePage extends ConsumerStatefulWidget {
  const MovieHomePage({super.key});

  @override
  ConsumerState<MovieHomePage> createState() => _MovieHomePageState();
}

class _MovieHomePageState extends ConsumerState<MovieHomePage> {
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final favorites = ref.watch(favoriteProvider);
    final searchQuery = ref.watch(searchQueryProvider);
    final selectedGenre = ref.watch(genreProvider);
    final allMovies = [...myList, ...topPicks];

    // Filter hasil pencarian + genre
    final searchResults = allMovies
        .where(
          (movie) =>
              (selectedGenre == "All" || movie.genre == selectedGenre) &&
              movie.title.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 13, 202),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.favorite, color: Colors.redAccent),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WishlistPage()),
            );
          },
        ),
        title: !isSearching
            ? const Text(
                "TONTONKEUN!",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              )
            : TextField(
                controller: searchController,
                autofocus: true,
                decoration: const InputDecoration(
                  hintText: "Cari film...",
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.white, fontSize: 18),
                onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                },
              ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 13, 202),
        actions: [
          if (!isSearching)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  dropdownColor: Colors.blueAccent,
                  iconEnabledColor: Colors.white,
                  value: selectedGenre,
                  items: [
                    "All",
                    "Action",
                    "Comedy",
                    "Drama",
                    "Romance",
                    "Animation",
                    "Sci-Fi",
                    "Adventure",
                    "Fantasy",
                    "Thriller",
                  ].map((genre) {
                    return DropdownMenuItem(
                      value: genre,
                      child: Text(
                        genre,
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    ref.read(genreProvider.notifier).state = value!;
                  },
                ),
              ),
            ),
          IconButton(
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchController.clear();
                  ref.read(searchQueryProvider.notifier).state = "";
                }
                isSearching = !isSearching;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            Image.asset(
              "assets/images/film1.png",
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 15),

            // Jika sedang mencari atau filter genre aktif
            if (isSearching || selectedGenre != "All")
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  sectionTitle(
                    "Hasil (${searchResults.length}) - Genre: $selectedGenre",
                  ),
                  movieList(searchResults, favorites),
                ],
              )
            else ...[
              sectionTitle("My List"),
              movieList(myList, favorites),
              const SizedBox(height: 20),
              sectionTitle("Top Picks For You"),
              movieList(topPicks, favorites),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget movieList(List<Movie> movies, List<String> favorites) {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: movies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie, favorites: favorites);
        },
      ),
    );
  }
}

// Widget kartu film
class MovieCard extends ConsumerWidget {
  final Movie movie;
  final List<String> favorites;

  const MovieCard({super.key, required this.movie, required this.favorites});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favList = ref.read(favoriteProvider.notifier);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => DetailMoviePage(movie: movie)),
        );
      },
      onDoubleTap: () {
        if (favorites.contains(movie.title)) {
          favList.state = List.from(favorites)..remove(movie.title);
        } else {
          favList.state = List.from(favorites)..add(movie.title);
        }
      },
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              movie.image,
              height: 140,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 100,
            child: Text(
              movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.star, color: Colors.yellow, size: 14),
              const SizedBox(width: 4),
              Text(
                movie.rating.toString(),
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              const SizedBox(width: 6),
              if (favorites.contains(movie.title))
                const Icon(Icons.favorite, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }
}

// ======================
// Detail Page
// ======================
class DetailMoviePage extends ConsumerWidget {
  final Movie movie;

  const DetailMoviePage({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);
    final favList = ref.read(favoriteProvider.notifier);
    final isFav = favorites.contains(movie.title);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 13, 202),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 13, 202),
        title: Text(
          movie.title,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.redAccent : Colors.white,
            ),
            onPressed: () {
              if (isFav) {
                favList.state = List.from(favorites)..remove(movie.title);
              } else {
                favList.state = List.from(favorites)..add(movie.title);
              }
            },
          )
        ],
      ),

      // =======================
      // BODY
      // =======================
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster seperti MovieCard (140px)
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  movie.image,
                  height: 200,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Judul + rating row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      movie.rating.toString(),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Genre
            Text(
              movie.genre,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),

            const SizedBox(height: 16),

            // Sinopsis
            Text(
              "Sinopsis",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // SINOPSIS 1 PARAGRAF
            Text(
              movie.description,
              style: const TextStyle(color: Colors.white70, fontSize: 15),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 24),

            // Tombol aksi
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (isFav) {
                      favList.state = List.from(favorites)..remove(movie.title);
                    } else {
                      favList.state =
                          List.from(favorites)..add(movie.title);
                    }
                  },
                  icon:
                      Icon(isFav ? Icons.favorite : Icons.favorite_border),
                  label:
                      Text(isFav ? "Remove Wishlist" : "Add to Wishlist"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                  ),
                ),
                const SizedBox(width: 12),

                // =====================
                // SHARE AKTIF
                // =====================
                OutlinedButton.icon(
                  onPressed: () {
                    Share.share(
                      "Rekomendasi Film: ${movie.title}\nGenre: ${movie.genre}\nRating: ${movie.rating}\n\nSinopsis:\n${movie.description}",
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text("Share"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white24),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ======================
// Wishlist Page
// ======================
class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoriteProvider);
    final allMovies = [...myList, ...topPicks];
    final wishlistMovies =
        allMovies.where((m) => favorites.contains(m.title)).toList();
    final favList = ref.read(favoriteProvider.notifier);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 13, 202),
      appBar: AppBar(
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 13, 202),
      ),
      body: wishlistMovies.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film di wishlist kamu!",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(10),
              itemCount: wishlistMovies.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final movie = wishlistMovies[index];
                return Card(
                  color: Colors.blueGrey[900],
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(movie.image, width: 60, fit: BoxFit.cover),
                    ),
                    title: Text(
                      movie.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          movie.genre,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        const SizedBox(width: 8),
                        const Icon(Icons.star, color: Colors.yellow, size: 14),
                        const SizedBox(width: 4),
                        Text(
                          movie.rating.toString(),
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        favList.state = List.from(favorites)..remove(movie.title);
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailMoviePage(movie: movie),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
