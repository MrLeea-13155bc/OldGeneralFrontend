//
//  FlagInfoPage.swift
//  OldGeneral
//
//  Created by 李毓琪 on 2023/2/26.
//

import SwiftUI

struct FlagInfoPage: View {
    init (_ info: Cdr_FlagDetailInfo) {
        flagInfo = info
        isOwner = userId == info.userID
    }
    var flagInfo: Cdr_FlagDetailInfo
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    private var usericon: Image = Image(systemName: "square.and.arrow.up.fill")
    private var isOwner: Bool = false
    @State private var jumpToSignPage: Bool = false
    
    var body: some View {
        VStack{
            HStack{
                circleImage(url: flagInfo.userAvatar)
                    .frame(maxWidth: 30,maxHeight: 30)
                Text(flagInfo.userName)
            }
            ScrollView{
                VStack{
                    HStack{
                        VStack(alignment: .leading,spacing: 10){
                            Text(flagInfo.flagName)
                            Text("\(flagInfo.starNum)点赞 \(flagInfo.siegeNum)围观")
                                .foregroundColor(.gray.opacity(0.7))
                                .font(.caption2)
                        }
                        Spacer()
                    }
                    .padding(.all,10)
                    HStack(spacing: 60){
                        FlagDetailInfoItem(description: "投币助力", data: String(flagInfo.siegeNum))
                        FlagDetailInfoItem(description: "挑战金币", data: String(flagInfo.challengeNum))
                        FlagDetailInfoItem(description: "挑战状态", data: flagInfo.flagStatus)
                    }
                    .padding()
                    .background(.gray.opacity(0.2))
                    .cornerRadius(12)
                }
                .padding(.bottom,4)
                Divider()
                LazyVGrid(columns: columns) {
                    FlagCardItem()
                        .onTapGesture {
                            jumpToSignPage = true
                        }
                    FlagCardItem()
                        .onTapGesture {
                            jumpToSignPage = true
                        }
                    FlagCardItem()
                        .onTapGesture {
                            jumpToSignPage = true
                        }
                }
                .padding(.all,30)
                .frame(maxHeight: .infinity)
            }
            Button {
                
            } label: {
                Text(isOwner ? "打卡" : "围观分钱")
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.primary)
            }
            .buttonStyle(.borderedProminent)
            .padding()
            .tint(.yellow.opacity(0.8))
        }
        .navigationDestination(isPresented: $jumpToSignPage) {
            SignInPage()
        }
    }
}

struct FlagInfoPage_Previews: PreviewProvider {
    static var previews: some View {
        let info = Cdr_FlagDetailInfo.with{ my in
            my.flagID = "flagId"
            my.flagName = "flagName"
            my.challengeNum = 100
            my.siegeNum = 100
            my.flagStatus = "进行中"
            my.starNum = 33
            my.userName = "username"
            my.userAvatar = "https://as1.ftcdn.net/v2/jpg/03/03/97/00/1000_F_303970065_Yi0UpuVdTb4uJiEtRdF8blJLwcT4Qd4p.jpg"
        }
        FlagInfoPage(info)
    }
}
