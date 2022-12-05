import { Module } from '@nestjs/common';
import { AuthModule } from './auth/auth.module';
import { SaleModule } from './sale/sale.module';
import { MatchModule } from './match/match.module';

@Module({
  imports: [AuthModule, SaleModule, MatchModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
