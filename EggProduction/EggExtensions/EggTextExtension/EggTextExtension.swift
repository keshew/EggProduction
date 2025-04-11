import SwiftUI

extension Text {
    func Madimi(size: CGFloat,
                color: Color = .mainBrown)  -> some View {
        self.font(.custom("MadimiOne-Regular", size: size))
            .foregroundColor(color)
    }
}
