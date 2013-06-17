<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>

<div id="content" class="ms-account-profile">
	<?php echo $content_top; ?>
	
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
		<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	
	<h1><?php echo $ms_account_sellerinfo_heading; ?></h1>
	
	<?php if (isset($success) && ($success)) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	
	<?php if (isset($statustext) && ($statustext)) { ?>
		<div class="<?php echo $statusclass; ?>"><?php echo $statustext; ?></div>
	<?php } ?>

	<p class="warning main"></p>
	
	<form id="ms-sellerinfo" class="ms-form">
		<input type="hidden" name="action" id="ms_action" />
		
		<div class="content">
			<!-- todo status check update -->
			<?php if ($seller['ms.seller_status'] == MsSeller::STATUS_DISABLED || $seller['ms.seller_status'] == MsSeller::STATUS_DELETED) { ?>
			<div class="ms-overlay"></div>
			<?php } ?>
			<table class="ms-product">
				<tr>
					<?php if (!empty($seller['ms.nickname'])) { ?>
						<td><?php echo $ms_account_sellerinfo_nickname; ?></td>
						<td style="padding-top: 5px">
							<b><?php echo $seller['ms.nickname']; ?></b>
						</td>
					<?php } else { ?>
						<td><span class="required">*</span> <?php echo $ms_account_sellerinfo_nickname; ?></td>
						<td>
							<input type="text" name="seller[nickname]" value="<?php echo $seller['ms.nickname']; ?>" />
							<p class="ms-note"><?php echo $ms_account_sellerinfo_nickname_note; ?></p>
						</td>
					<?php } ?>
				</tr>
				
				<tr>
					<td><?php echo $ms_account_sellerinfo_description; ?></td>
					<td>
						<!-- todo strip tags if rte disabled -->
						<textarea name="seller[description]" id="seller_textarea" class="<?php echo $this->config->get('msconf_enable_rte') ? "ckeditor" : ''; ?>"><?php echo $seller['ms.description']; ?></textarea>
						<p class="ms-note"><?php echo $ms_account_sellerinfo_description_note; ?></p>
					</td>
				</tr>
				
				<tr>
					<td><?php echo $ms_account_sellerinfo_company; ?></td>
					<td>
						<input type="text" name="seller[company]" value="<?php echo $seller['ms.company']; ?>" />
						<p class="ms-note"><?php echo $ms_account_sellerinfo_company_note; ?></p>
					</td>
				</tr>
				
				<tr>
					<td><?php echo $ms_account_sellerinfo_country; ?></td>
					<td>
						<select name="seller[country]">
							<option value="" selected="selected"><?php echo $ms_account_sellerinfo_country_dont_display; ?></option>
							<?php foreach ($countries as $country) { ?>
							<option value="<?php echo $country['country_id']; ?>" <?php if ($seller['ms.country_id'] == $country['country_id']) { ?>selected="selected"<?php } ?>><?php echo $country['name']; ?></option>
							<?php } ?>
						</select>
						<p class="ms-note"><?php echo $ms_account_sellerinfo_country_note; ?></p>
					</td>
				</tr>
				
				<tr>
					<td><?php echo $ms_account_sellerinfo_paypal; ?></td>
					<td>
						<input type="text" name="seller[paypal]" value="<?php echo $seller['ms.paypal']; ?>" />
						<p class="ms-note"><?php echo $ms_account_sellerinfo_paypal_note; ?></p>
					</td>
				</tr>
				
				<tr>
					<td><?php echo $ms_account_sellerinfo_avatar; ?></td>
					<td>
						<!--<input type="file" name="ms-file-selleravatar" id="ms-file-selleravatar" />-->
						<a name="ms-file-selleravatar" id="ms-file-selleravatar" class="button"><span><?php echo $ms_button_select_image; ?></span></a>
						<p class="ms-note"><?php echo $ms_account_sellerinfo_avatar_note; ?></p>
						<p class="error" id="error_sellerinfo_avatar"></p>
						
						<div id="sellerinfo_avatar_files">
						<?php if (!empty($seller['avatar'])) { ?>
							<div class="ms-image">
								<input type="hidden" name="seller[avatar_name]" value="<?php echo $seller['avatar']['name']; ?>" />
								<img src="<?php echo $seller['avatar']['thumb']; ?>" />
								<img class="ms-remove" src="catalog/view/theme/default/image/remove.png" />
							</div>
						<?php } ?>
						</div>
					</td>
				</tr>
				
				<?php if ($ms_account_sellerinfo_terms_note) { ?>
				<tr>
					<td><?php echo $ms_account_sellerinfo_terms; ?></td>
					<td>
						<p style="margin-bottom: 0">
							<input type="checkbox" name="accept_terms" value="1" />
							<?php echo $ms_account_sellerinfo_terms_note; ?>
						</p>
					</td>
				</tr>
				<?php } ?>
				
				<?php if (!isset($seller['seller_id']) &&$seller_validation != MsSeller::MS_SELLER_VALIDATION_NONE) { ?>
				<tr>
					<td><?php echo $ms_account_sellerinfo_reviewer_message; ?></td>
					<td>
						<textarea name="seller[reviewer_message]" id="message_textarea"></textarea>
						<p class="ms-note"><?php echo $ms_account_sellerinfo_reviewer_message_note; ?></p>
					</td>
				</tr>
				<?php } ?>
			</table>
		</div>
		</form>
		
		<?php if (isset($group_commissions) && $group_commissions[MsCommission::RATE_SIGNUP]['flat'] > 0) { ?>
			<p class="attention ms-commission">
				<?php echo sprintf($this->language->get('ms_account_sellerinfo_fee_flat'),$this->currency->format($group_commissions[MsCommission::RATE_SIGNUP]['flat'], $this->config->get('config_currency')), $this->config->get('config_name')); ?>
				<?php echo $ms_commission_payment_type; ?>
			</p>
			
			<?php if(isset($payment_form)) { ?><div class="ms-payment-form"><?php echo $payment_form; ?></div><?php } ?>
		<?php } ?>
		
		<div class="buttons">
			<div class="left">
				<a href="<?php echo $link_back; ?>" class="button">
					<span><?php echo $button_back; ?></span>
				</a>
			</div>
			
			<?php if ($seller['ms.seller_status'] != MsSeller::STATUS_DISABLED && $seller['ms.seller_status'] != MsSeller::STATUS_DELETED) { ?>
			<div class="right">
				<a class="button" id="ms-submit-button">
					<span><?php echo $ms_button_save; ?></span>
				</a>
			</div>
			<?php } ?>
		</div>
	<?php echo $content_bottom; ?>
</div>

<?php $timestamp = time(); ?>
<script>
	var msGlobals = {
		timestamp: '<?php echo $timestamp; ?>',
		token : '<?php echo md5($salt . $timestamp); ?>',
		session_id: '<?php echo session_id(); ?>',
		uploadError: '<?php echo htmlspecialchars($ms_error_file_upload_error, ENT_QUOTES, "UTF-8"); ?>',
		config_enable_rte: '<?php echo $this->config->get('msconf_enable_rte'); ?>'
	};
</script>
<?php echo $footer; ?>