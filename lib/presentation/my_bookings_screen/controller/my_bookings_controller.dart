import 'package:get/get.dart';

class BookingModel {
  final String name;
  final String location;
  final String date;
  final String time;
  final String rating;
  final String imageUrl;
  final String status; // "Meeting Room booked" etc.

  BookingModel({
    required this.name,
    required this.location,
    required this.date,
    required this.time,
    required this.rating,
    required this.imageUrl,
    required this.status,
  });
}

class MyBookingsController extends GetxController {
  RxInt selectedTabIndex = 0.obs; // 0: Upcoming, 1: Past

  final List<BookingModel> upcomingBookings = <BookingModel>[
    BookingModel(
      name: "Chai Point",
      location: "Raiya Road, Rajkot",
      date: "11 Oct 2025, Tuesday",
      time: "12:30 pm-2:00pm",
      rating: "4.7/5",
      imageUrl: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      status: "Meeting Room booked",
    ),
    BookingModel(
      name: "Tea Post",
      location: "Kalavad Road, Rajkot",
      date: "11 Oct 2025, Tuesday",
      time: "12:30 pm-2:00pm",
      rating: "4.7/5",
      imageUrl: "https://images.unsplash.com/photo-1559339352-11d035aa65de?q=80&w=1974&auto=format&fit=crop",
      status: "Meeting Room booked",
    ),
    BookingModel(
      name: "Third Wave Coffee",
      location: "Amin Marg, Rajkot",
      date: "11 Oct 2025, Tuesday",
      time: "12:30 pm-2:00pm",
      rating: "4.7/5",
      imageUrl: "https://images.unsplash.com/photo-1521017432531-fbd92d768814?q=80&w=2070&auto=format&fit=crop",
      status: "Meeting Room booked",
    ),
  ].obs;

  final List<BookingModel> pastBookings = <BookingModel>[
    BookingModel(
      name: "Blue Tokai Coffee",
      location: "150 Feet Ring Road, Rajkot",
      date: "10 Sep 2025, Monday",
      time: "10:00 am-11:00am",
      rating: "4.7/5",
      imageUrl: "https://images.unsplash.com/photo-1554118811-1e0d58224f24?q=80&w=2047&auto=format&fit=crop",
      status: "Completed",
    ),
  ].obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  void cancelBooking(BookingModel booking) {
    upcomingBookings.remove(booking);
    update();
  }
}
