## getX

```bash
flutter pub add get #라이브러리추가
```

## Stateless
> 상태가 지속적으로 변하지않는 무언가 
## Stateful
> 상태개  지속적으로 변하는 무언가 

## stateless 라이프사이클 
- Constructor
- Build ()

### Stateful widget 라이프사이클 
- Constructor
- createState , setState()
  - initState()
    - setState일경우 didUpdateWidget() 발동 후 Build()
  - didChangeDependencies
  - Build()

```agsl
@override
void initState(){ //생성이후  최초 한번만 실행된다 .
..
..
}
```

```agsl


 bool stateBool = false;
  @override
  void initState() {
    super.initState();
    print("init State!!");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    print("didChangeDependencies !! ");
  }

  @override
  Widget build(BuildContext context) {
    print("build !! ");

    return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: Container(
            child: Center(
                child: Text(widget.rabbit.state.toString(),
                    style: TextStyle(fontSize: 20)))),
        floatingActionButton: FloatingActionButton(
          //버튼
          onPressed: () {
            setState(() {
              stateBool = !stateBool;
            });
          },
          child: Text("버튼"),
        ));
  }
  
 //flutter: init State!!
//flutter: didChangeDependencies !!
//flutter: build !!


// 위구문을 실행했을경우 initState가 먼저 실행된이후 didchange, build 이런식으로 호출되는것을알수있다. 
```

### initState의 차이점  didChangeDependencies
```dart
@override
void initState(){ //생성이후  최초 한번만 실행된다 .
super.initState();
}

  @override
  void didChangeDependencies() { 
  //컨텍스트접근할시 
    super.didChangeDependencies();
    print(MediaQuery.of(context).size); // 디바이스 사이즈 체크 

  }

```
- 가장 큰 차이점으로는 컨텍스트에 접근할수있냐없냐의 차이 . 


### Widget Build 
- 상태변화가 있을때 호출됨 
- 부모의 위젯에서 업데이트가 감지되어있을때 호출 
- Build 부분에 계산로직이 많이들어가면 퍼포먼스가 많이 낮아지는 현상이 발생됨 그러므로 didChangeDependencies에서 하는걸 추천 


### setState 
> 상태 변화
```dart
  @override
void setState(fn) {
  super.setState(fn);
  print("setState !! ");
}

// setState도 이렇게 오버라이드해서 정의해줄수도있다. 
```
- setState를 사용할때 무조건 mount되었는지 검사하자.
  - 이 이유에대해서는 내가 직접적으로 문제를 직면하진않았지만가끔 위젯이 마운트 도 되지않은 상태에서 setState가 발동되기도함 
- 여기서 mount 란 ? 
  - 라이프사이클에서 맨처음 createState가 시작되는데 , 모든 위젯은 this.mounted: bool 속성ㄹ으 가지고 있다. buildContext가 할당될때 this.mounted는 true로 
    바뀌면서  이후 initState -> didChangeDependencies ->Build() 로 된다 . 


### didUpdateWidget
- 이전상태의 자신과 비교하여 상태가 변경이되었는지 확인할수있는 
```dart

  @override
  void didUpdateWidget(covariant StatefulSampleWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }
```




### despose
- 사용되었던것들을 영구적으로 삭제할때 불러옴
  - 대표적으로 위젯에서 사용된 컨트롤러들을 삭제함 
    - 애니메이션 컨트롤러, 페이지컨트롤러 
  - 컨트롤러를 despose를 안하면 앱이 커지고 시간이 가면갈수록 퍼포먼스가 현저히 떨어지게됨 
    - 습관적으로 하는게 좋다 .
```dart
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

```
# Widget Layout
- ## [ScaffoldWidget](https://github.com/jhva/flutter-practice/blob/main/ScaffoldWidget.md)



