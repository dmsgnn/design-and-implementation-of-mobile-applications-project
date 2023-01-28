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

    // Variables for header
    var safeArea: EdgeInsets
    var size: CGSize
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .top) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        Text("Home")
                            .foregroundColor(.black)
                            .font(.system(size: UIScreen.main.bounds.width * 0.1, weight: .bold))
                            .padding(.top, 10)
                            .padding(.leading, -UIScreen.main.bounds.width * 0.4)
                        
                        VStack(alignment: .leading) {
                            ForEach(viewModel.collections){ collection in
                                NavigationLink(destination: SummaryCollectionView(collection: collection)) {
                                    MainCollectionView(collection: collection)
                                    
                                        
                                                    

                                
                                    
                                    
                                        //.shadow(color: .black.opacity(0.2), radius: 1, x: 6, y: 6)
                                        //.blur(radius: 8, opaque: false)
                            
                            
                                }
                                Divider().padding(.horizontal)
                            }
                            
                        }
                    }
                    .overlay(alignment: .top) {
                        HeaderView()
                    }
                }
                .background(Color.white)
                .refreshable {
                    viewModel.updateHome()
                }

            }
        }
        .onTapGesture {
            hideTabBar()
            //                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.7))
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

struct ProgressBar: View {
    var progress: Float
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: UIScreen.main.bounds.width*0.03)
                .opacity(0.3)
                .foregroundColor(Color.gray)
                .frame(width: UIScreen.main.bounds.width*0.1)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progress, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: UIScreen.main.bounds.width*0.03, lineCap: .round, lineJoin: .round))
                .foregroundColor(Color.black)
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear)
                .frame(width: UIScreen.main.bounds.width*0.1)


            Text(String(format: "%.0f %%", min(self.progress, 1.0)*100.0))
                .font(.headline)
                .bold()
                .padding(.top, 80)
                .foregroundColor(.black)
        }
    }
}

struct DashboardView_Previews : PreviewProvider {
    static var previews: some View {        
        GeometryReader{
            let safeArea = $0.safeAreaInsets
            let size = $0.size
            DashboardView(viewModel: DashboardViewModel(), safeArea: safeArea, size: size)
                .ignoresSafeArea(.container, edges: .top)
        }
    }
}

