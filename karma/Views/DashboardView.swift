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
                                ForEach(viewModel.campaigns){ collection in
                                    HStack(spacing: UIScreen.main.bounds.width * 0.1){
                                        
                                        KFImage(URL(string: collection.collectionImageUrl ?? ""))
                                            .resizable()
                                            .scaledToFill()
                                            .clipShape(Circle())
                                            .frame(width: 80, height: 80)
                                            .padding(.leading, 20)


                                        
                                        VStack(alignment: .leading) {
                                            Text(collection.title)
                                                .font(.title2)
                                                .fontWeight(.semibold)
                                                .padding(.bottom, 2)
                                                .lineLimit(1)
                                            
                                            Text(collection.caption)
                                                .font(.subheadline)
                                                .fontWeight(.semibold)
                                                .foregroundColor(Color(.systemGray))
                                                .lineLimit(2)
                                        }
                                        .padding(.vertical)
                                        
                                        Text("\(collection.currentAmount / collection.amount * 100, specifier: "%.1f") %")
                                            .font(.title2)
                                            .fontWeight(.semibold)
                                            .padding(.trailing)
                                            
                                        //.offset(y: -14)
                                    }
                                    .frame(width: UIScreen.main.bounds.width * 0.95, height: UIScreen.main.bounds.width * 0.35)
                                    .background(Color(.yellow))
                                    .clipShape(RoundedRectangle(cornerRadius: 45))
                                    .padding(.bottom, UIScreen.main.bounds.width * 0.01)
                                }
                                
                            }
                    }
                }
                .background(Color.white)
                .refreshable {
                    viewModel.updateHome()
                }
            }
        }
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
        DashboardView(viewModel: DashboardViewModel())
    }
}

