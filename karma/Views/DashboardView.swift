//
//  DashboardView.swift
//  karma
//
//  Created by Giovanni Demasi on 26/12/22.
//
import SwiftUI
import Kingfisher

struct DashboardView: View {
    @StateObject var viewModel: DashboardViewModel
    @State var showHeaderBar = false
    let screenHeight = UIScreen.main.bounds.height
    let screenWidth = UIScreen.main.bounds.width
    
    @State private var showNewCollectionView = false
    @State private var orientation = UIDevice.current.orientation
    
    
    // Variables for header
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View {
        if UIDevice.isIPad {
            NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            Image("kLogo-40")
                            Text("arma")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .offset(x: -4, y: 5)
                            Spacer()
                            Button {
                                showNewCollectionView.toggle()
                            } label: {
                                
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 35, height: 35)
                                    .padding(.all, 10)
                                    .fontWeight(.semibold)
                            }
                            .foregroundColor(.black)
                            .offset(x: -4, y: 5)
                            .fullScreenCover(isPresented: $showNewCollectionView) {
                                UploadCollectionView()
                            }
                        }
                        //                        .padding(.top, 6)
                        .padding(.horizontal)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            VStack(alignment: .center) {
                                ForEach(viewModel.collections){ collection in
                                    NavigationLink(destination: SummaryCollectionView(collection: collection)) {
                                        iPadMainCollectionView(collection: collection)
                                        
                                    }
                                    
                                    Divider().padding(.horizontal)
                                }
                                
                            }
                            
                            Spacer().frame(height: 60)
                        }
                    }
                    .background(Color.white)
                    .refreshable {
                        viewModel.updateHome()
                    }
                    
                }
            }
        } else {
            NavigationStack {
                ZStack {
                    VStack {
                        HStack {
                            Image("kLogo-29")
                            Text("arma")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .offset(x: -4, y: 5)
                                .id("home")
                            
                            Spacer()
                            
                            Button {
                                showNewCollectionView.toggle()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 20, height: 20)
                                    .padding(.all, 10)
                                    .fontWeight(.semibold)
                                
                            }
                            .background(Color(.black))
                            .foregroundColor(.white)
                            .clipShape(Circle())
                            //                            .padding()
                            .offset(x: -4, y: 5)
                            .fullScreenCover(isPresented: $showNewCollectionView) {
                                UploadCollectionView()
                            }
                            
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            ForEach(viewModel.collections){ collection in
                                NavigationLink(destination: SummaryCollectionView(collection: collection)) {
                                    MainCollectionView(collection: collection)
                                }
                                
                                Divider().padding(.horizontal)
                            }
                        }
                        Spacer().frame(height: 60)
                    }
                    .id("scrollv")
                    
                }
                .background(Color.white)
                .refreshable {
                    viewModel.updateHome()
                }
            }
        }
    }
    
    // MARK: HeaderView
    @ViewBuilder
    func HeaderView()->some View{
        GeometryReader{proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let height = size.height * 0.0
            let progress = minY / (height * (minY > 0 ? 0.5 : 0.8))
            let titleProgress = minY / height
            
            HStack(spacing: 15){
                Spacer(minLength: 0)
                
            }
            .overlay(content: {
                Text("Home")
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                // Your Choice Where to display the title
                    .offset(y: -titleProgress > 0.75 ? 0 : 45)
                    .clipped()
                    .animation(.easeInOut(duration: 0.25), value: -titleProgress > 0.75)
            })
            .padding(.top,safeArea.top + 10)
            .padding([.horizontal,.bottom],15)
            .background(content: {
                Color.white
                    .opacity(-progress > 1 ? 1 : 0)
            })
            .offset(y: -minY)
        }
        .frame(height: 35)
        .id("header")
    }
    
    
}

//
//struct CampaignCell: View {
//    var campaign: Collection
//    var body: some View{
//        HStack {
//            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01){
//                Text(campaign.title)
//                    .fontWeight(.bold)
//                    .lineLimit(1)
//
//                Text(campaign.caption)
//                    .lineLimit(2)
//
//                Text("\(campaign.currentAmount) / \(campaign.amount)")
//                    .fontWeight(.semibold)
//            }
//        }
//    }
//}

struct DashboardView_Previews : PreviewProvider {
    static var previews: some View {
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            DashboardView(viewModel: DashboardViewModel(userService: UserService(), service: CollectionService()), safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

