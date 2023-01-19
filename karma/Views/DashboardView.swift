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
                                    
                                    HStack(spacing: UIScreen.main.bounds.width * 0.1){
                                        
                                        if(collection.collectionImageUrl != nil)
                                        {
                                        KFImage(URL(string: collection.collectionImageUrl ?? ""))
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 80, height: 80)
                                            .padding(.leading, 20)
                                            
                                        }
                                        else {
                                            ZStack(alignment: .center) {
                                                Circle()
                                                    .fill(.black)
                                                    .frame(width: 80, height: 80)
                                                    .padding(.leading, 20)
                                                Image(systemName: "sun.max")
                                                    .resizable()
                                                    .aspectRatio(1.0, contentMode: .fit)
                                                    .frame(width: 30, height: 30)
                                                    .foregroundColor(.white)
                                                    .padding(.leading, 20)
                                            }
                                        }
                                        
                                        
                                        
                                        VStack(alignment: .leading) {
                                            Text(collection.title)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                                .padding(.bottom, 2)
                                                .lineLimit(1)
                                                .foregroundColor(.black)
                                            
                                            Text(collection.caption)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(.black))
                                                .lineLimit(2)
                                                .multilineTextAlignment(.leading)
                                        }
                                        .padding(.vertical)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        
                                        Text("\(collection.currentAmount / collection.amount * 100, specifier: "%.1f") %")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.trailing, 20)
                                            .foregroundColor(.black)
                                        
                                        //.offset(y: -14)
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.width * 0.35)
                                    .background(Color(.yellow)
                                        //.shadow(color: .black.opacity(0.2), radius: 1, x: 6, y: 6)
                                        //.blur(radius: 8, opaque: false)
                                    )
                                    .clipShape(RoundedRectangle(cornerRadius: 45))
                                    .padding(.bottom, UIScreen.main.bounds.width * 0.01)
                                    
                                }
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


struct CampaignCell: View {
    var campaign: Collection
    var body: some View{
        HStack {
            VStack(alignment: .leading, spacing: UIScreen.main.bounds.height * 0.01){
                Text(campaign.title)
                    .fontWeight(.bold)
                    .lineLimit(1)
                
                Text(campaign.caption)
                    .lineLimit(2)
                
                Text("\(campaign.currentAmount) / \(campaign.amount)")
                    .fontWeight(.semibold)
            }
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

