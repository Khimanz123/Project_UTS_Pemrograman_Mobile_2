import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// Provider untuk menyimpan daftar film favorit (wishlist)
final favoriteProvider = StateProvider<List<String>>((ref) => []);

// Provider untuk teks pencarian
final searchQueryProvider = StateProvider<String>((ref) => "");

// Provider untuk genre yang sedang dipilih
final genreProvider = StateProvider<String>((ref) => "All");

// Data Model Film
class Movie {
  final String title;
  final String image;
  final String genre;
  Movie(this.title, this.image, this.genre);
}

// Daftar Film
final myList = [
  Movie("Jurassic World", "assets/images/film1.png", "Action"),
  Movie("Home Alone", "assets/images/film2.png", "Comedy"),
  Movie("World War Z", "assets/images/film3.png", "Thriller"),
  Movie("Deadpool", "assets/images/film4.png", "Action"),
  Movie("The Long Walk", "assets/images/film5.png", "Drama"),
  Movie("Fast & Furious", "assets/images/film6.png", "Action"),
  Movie("Beauty and The Beast", "assets/images/film7.png", "Romance"),
  Movie("Coco", "assets/images/film8.png", "Animation"),
  Movie("Up", "assets/images/film9.png", "Animation"),
  Movie("Harry Potter", "assets/images/film10.png", "Fantasy"),
  Movie("Avatar", "assets/images/film11.png", "Sci-Fi"),
  Movie("Joker", "assets/images/film12.png", "Drama"),
];

final topPicks = [
  Movie("Titanic", "assets/images/film13.png", "Romance"),
  Movie("The Meg", "assets/images/film14.png", "Action"),
  Movie("Inception", "assets/images/film15.png", "Sci-Fi"),
  Movie("Jumanji", "assets/images/film16.png", "Adventure"),
  Movie("Hulk", "assets/images/film17.png", "Action"),
  Movie("Captain America", "assets/images/film18.png", "Action"),
  Movie("Avengers: Endgame", "assets/images/film19.png", "Action"),
  Movie("The Batman", "assets/images/film20.png", "Action"),
  Movie("Toy Story 4", "assets/images/film21.png", "Animation"),
  Movie("Spiderman", "assets/images/film22.png", "Action"),
  Movie("Finding Nemo", "assets/images/film23.png", "Animation"),
  Movie("Cars", "assets/images/film24.png", "Animation"),
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
                  items:
                      [
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
class MovieCard extends ConsumerStatefulWidget {
  final Movie movie;
  final List<String> favorites;

  const MovieCard({super.key, required this.movie, required this.favorites});

  @override
  ConsumerState<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends ConsumerState<MovieCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    final favList = ref.read(favoriteProvider.notifier);

    return GestureDetector(
      onTap: () {
        setState(() => isTapped = !isTapped);
      },
      onDoubleTap: () {
        if (widget.favorites.contains(widget.movie.title)) {
          favList.state = List.from(widget.favorites)
            ..remove(widget.movie.title);
        } else {
          favList.state = List.from(widget.favorites)..add(widget.movie.title);
        }
      },
      child: AnimatedScale(
        scale: isTapped ? 1.1 : 1.0,
        duration: const Duration(milliseconds: 300),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                widget.movie.image,
                height: 140,
                width: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              widget.movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 12),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
            if (widget.favorites.contains(widget.movie.title))
              const Icon(Icons.favorite, color: Colors.red, size: 16),
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
    final wishlistMovies = allMovies
        .where((m) => favorites.contains(m.title))
        .toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 13, 202),
      appBar: AppBar(
        title: const Text(
          "My Wishlist",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 0, 13, 202),
      ),
      body: wishlistMovies.isEmpty
          ? const Center(
              child: Text(
                "Belum ada film di wishlist kamu 😢",
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
                      child: Image.asset(movie.image, width: 60),
                    ),
                    title: Text(
                      movie.title,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      movie.genre,
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: const Icon(
                      Icons.favorite,
                      color: Color.fromARGB(255, 0, 13, 202),
                      size: 22,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
