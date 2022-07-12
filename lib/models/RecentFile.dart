class RecentFile {
  final String? icon, title, date, size, uid;
  bool online;
  RecentFile(
      {this.icon,
      this.title,
      this.date,
      this.size,
      this.online = false,
      required this.uid});
}

List demoRecentFiles = [
  RecentFile(
      icon: "assets/icons/xd_file.svg",
      title: "XD File",
      date: "01-03-2021",
      size: "3.5mb",
      uid: "1",
      online: true),
  RecentFile(
    icon: "assets/icons/Figma_file.svg",
    title: "Figma File",
    date: "27-02-2021",
    size: "19.0mb",
    uid: "2",
  ),
  RecentFile(
    icon: "assets/icons/doc_file.svg",
    title: "Document",
    date: "23-02-2021",
    size: "32.5mb",
    uid: "3",
  ),
  RecentFile(
    icon: "assets/icons/sound_file.svg",
    title: "Sound File",
    date: "21-02-2021",
    size: "3.5mb",
    uid: "7",
  ),
  RecentFile(
    icon: "assets/icons/media_file.svg",
    title: "Media File",
    date: "23-02-2021",
    size: "2.5gb",
    uid: "4",
  ),
  RecentFile(
    icon: "assets/icons/pdf_file.svg",
    title: "Sales PDF",
    date: "25-02-2021",
    size: "3.5mb",
    uid: "5",
  ),
  RecentFile(
    icon: "assets/icons/excle_file.svg",
    title: "Excel File",
    date: "25-02-2021",
    size: "34.5mb",
    uid: "6",
  ),
];
