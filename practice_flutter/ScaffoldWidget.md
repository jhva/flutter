

### Scaffold 

```dart
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: Text("scaffold")),
    body: const Center(
      child: TextField(),
    ),
    drawer: const Drawer(child: Center(child: Text("슬라이드메뉴"))), // 햄버거
    //endDrawer를 하게되면 오른쪽으로 배치 ,
    resizeToAvoidBottomInset: false, // floatingActionbutton을 TextField에서
    // 클릭시 밀려올라오지않게할려면 false
    drawerEdgeDragWidth: 100, // 사이즈가 100영역정도에서 마우스로 끌어오면 drawer가 열리게됨
    drawerEnableOpenDragGesture: false, // 위 drag하는것을 끌수있음 기본이 true
    drawerScrimColor: Colors.red.withOpacity(0.5), //햄버거열릴때 아웃사이더 색상
    floatingActionButton: FloatingActionButton(
      //아래쪽 버튼
      onPressed: () {
        print("클릭");
      },
      child: Icon(Icons.edit),
      backgroundColor: Colors.green,
    ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: 0,
      onTap: (index) {
        print(index); //이 함수를 통해 route를 달아주면되겠다!
      },
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Messages"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
      ],
    ),
  );
```